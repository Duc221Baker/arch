#!/bin/bash

set -e

echo "=== 1. Sync system time ==="
timedatectl set-ntp true

swapoff -a

DISK="/dev/nvme0n1"
PART_BOOT="${DISK}p1"
PART_ROOT="${DISK}p2"

echo "=== 2. Partition disk ($DISK) ==="

# Remove existing partition table and signatures
sgdisk --zap-all "$DISK"
wipefs -af "$DISK"

# Create GPT partitions: 1 GiB EFI and remaining space for root
sfdisk --wipe-partitions always "$DISK" <<EOF
label: gpt
size=1G, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
type=4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
EOF

# Notify kernel
partprobe "$DISK"
udevadm settle

echo "=== 3. Format and mount partitions ==="
mkfs.fat -F 32 "$PART_BOOT"
mkfs.ext4 "$PART_ROOT"

mount "$PART_ROOT" /mnt
mount --mkdir -o fmask=0077,dmask=0077 "$PART_BOOT" /mnt/boot

echo "=== 4. Install base packages ==="

pacstrap -K /mnt base linux linux-firmware intel-ucode

echo "=== 5. Generate fstab ==="
genfstab -U /mnt >> /mnt/etc/fstab

echo "=== 6. Configure system ==="
ROOT_UUID=$(blkid -s UUID -o value "$PART_ROOT")

echo "=== 7. Write system configuration files ==="
# Configure locale, console keymap, and hostname
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
echo "KEYMAP=us" > /mnt/etc/vconsole.conf
echo "Duc221Baker" > /mnt/etc/hostname
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /mnt/etc/locale.gen

# Configure systemd-boot
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

echo "=== 8. Apply configuration inside chroot ==="
arch-chroot /mnt bash -c '
    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
    hwclock --systohc
    locale-gen
    pacman -S --noconfirm networkmanager sudo nano fastfetch git base-devel
    systemctl enable NetworkManager
    echo "=== Enter root password ==="
    passwd
'

arch-chroot -S /mnt bash -c '
    bootctl install
    bootctl list
'
