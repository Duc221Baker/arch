## Install arch
**Connect internet first**  
**Install**  
curl -fLO https://raw.githubusercontent.com/Duc221Baker/arch/refs/heads/main/arch-install.sh  
bash arch-install.sh  
arch-chroot /mnt  
curl -fLO https://raw.githubusercontent.com/Duc221Baker/arch/refs/heads/main/root-block-nvidia.sh  
bash root-block-nvidia.sh  
rm root-block-nvidia.sh  
exit  
umount -R /mnt  
reboot  

## Connect wifi
nmcli device wifi connect *SSID* password *PASSWORD*  
nmcli connection modify *SSID* connection.autoconnect yes  

## Configure user
useradd -m *username*  
passwd *username*  
usermod -aG wheel *username*  
sudo EDITOR=nano visudo  
**Uncomment** *%wheel ALL=(ALL:ALL) ALL*  
**Logout and login with regular user**  
## Configure system
sudo pacman -Syu  
git clone https://github.com/Duc221Baker/arch  
chmod +x ~/arch/*.sh  
cd arch  
./install-yay.sh  
./intel-gpu.sh  
./disable-hibernate.sh  
./cache-ram.sh  
./zram.sh  
sudo reboot  
## Install & Configure Noctalia Greeter Umbriel Fonts Audio
cd ~/arch  
./install-noctalia-umbriel-greeter.sh  
nano ~/.config/umbriel/config.toml  
<i>
[general]  
autostart = [  
    "noctalia"  
]  
[layout]  
mode = "scrolling"  
gap = 0  
[keybinds]  
\# Applications and session  
"Mod+T" = { action = "spawn kitty", repeat = false }  
**Change**  
"Mod+T" = { action = "window-toggle-floating", repeat = false }  to Mod + V  
"Mod+Shift+T" = { action = "window-focus-switch-floating", repeat = false }  to Mod+Shift+V  
</i>
./setup-pipewire-audio.sh  
./install-fonts.sh  
sudo reboot  
## Gnome-keyring
cd ~/arch  
./install-gnome-keyring.sh  
sudo reboot  
## Install & Configure apps
cd ~/arch  
./xdg-portal.sh  
./install-cloud-flare-warp.sh  
./install-apps.sh  
./setup-kde-dolphin.sh  
./util.sh  
sudo reboot  
