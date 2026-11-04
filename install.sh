#!/bin/bash
set -e # Dừng lại ngay lập tức nếu có bất kỳ lệnh nào bị lỗi

echo "=== 1. Cập nhật thời gian ==="
timedatectl set-ntp true

swapoff -a

DISK="/dev/nvme0n1"
PART_BOOT="${DISK}p1"
PART_ROOT="${DISK}p2"

echo "=== 2. Phân vùng ổ đĩa ($DISK) ==="


# Xoá chữ ký cũ để tránh bị fdisk hỏi xác nhận
wipefs -af "$DISK"

# Chia ổ bằng sfdisk: p1 (1GiB EFI), p2 (toàn bộ còn lại - Root x86-64)
sfdisk "$DISK" <<EOF
label: gpt
size=1G, type=U
type=4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
EOF

echo "=== 3. Định dạng và Mount phân vùng ==="
mkfs.fat -F 32 "$PART_BOOT"
mkfs.ext4 -F "$PART_ROOT"

mount "$PART_ROOT" /mnt
mount --mkdir -o fmask=0077,dmask=0077 "$PART_BOOT" /mnt/boot

echo "=== 4. Cài đặt gói cơ bản (pacstrap) ==="
# Cài luôn intel-ucode, nano, networkmanager ở đây để tiết kiệm thời gian
pacstrap -K /mnt base linux linux-firmware intel-ucode nano networkmanager

echo "=== 5. Tạo fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab

echo "=== 6. Cấu hình hệ thống bên trong chroot ==="
ROOT_UUID=$(blkid -s UUID -o value "$PART_ROOT")

echo "=== 6. Ghi các file cấu hình hệ thống ==="
# Ghi cấu hình Locale, Console, Hostname trực tiếp vào /mnt
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
echo "KEYMAP=us" > /mnt/etc/vconsole.conf
echo "Duc221Baker" > /mnt/etc/hostname
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /mnt/etc/locale.gen

# Tạo cấu hình Bootloader (systemd-boot)
mkdir -p /mnt/boot/loader/entries

cat << 'EOF' > /mnt/boot/loader/loader.conf
default  arch.conf
timeout  3
console-mode max
editor   no
EOF

cat << EOF > /mnt/boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=UUID=${ROOT_UUID} rw
EOF

echo "=== 7. Thực thi cấu hình bên trong chroot ==="
arch-chroot -S /mnt bash -c '
    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
    hwclock --systohc
    locale-gen
    systemctl enable NetworkManager
    bootctl install
    bootctl list
'

echo "=========================================="
echo ">>> VUI LÒNG NHẬP MẬT KHẨU ROOT DƯỚI ĐÂY <<<"
echo "=========================================="
arch-chroot -S /mnt passwd

echo "=== Cài đặt hoàn tất! Đang khởi động lại... ==="
umount -R /mnt
reboot

