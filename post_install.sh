#!/bin/bash

# Update the system
sudo pacman -Syu --noconfirm

# Install and configure necessary packages and tools
sudo pacman -S nano git vim neofetch --noconfirm
sudo nano /etc/pacman.conf
sudo pacman -Sy --noconfirm

# Install and configure reflector for mirrorlist optimization
sudo pacman -S reflector --noconfirm
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy --noconfirm

# Install and setup GUI (example with GNOME)
#sudo pacman -S xorg gnome gnome-extra gnome-tweaks gdm --noconfirm
#sudo systemctl enable gdm.service
#sudo systemctl start gdm.service

# Install essential packages and Bluetooth support
sudo pacman -S bluez blueman bluez-utils --noconfirm
sudo modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Install development tools, filesystem utilities, and JDK
sudo pacman -S p7zip unrar tar rsync htop exfat-utils fuse-exfat ntfs-3g flac jasper aria2 jdk-openjdk --noconfirm

# Install microcode updates
sudo pacman -S amd-ucode # or intel-ucode for INTEL CPUs
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Install Yay for AUR support and Flatpak
sudo pacman -S --needed base-devel git flatpak --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si

# Install GUI applications
sudo pacman -S firefox libreoffice-fresh vlc gimp thunderbird kdenlive krita --noconfirm

# Install additional kernels
sudo pacman -S linux-lts linux-lts-headers linux-hardened linux-hardened-headers linux-zen linux-zen-headers --noconfirm

# Set up Timeshift and Preload for backups and performance
yay -Sy timeshift preload --noconfirm
sudo systemctl enable preload.service

# Configure the firewall
sudo pacman -S ufw --noconfirm
sudo systemctl enable ufw.service
sudo systemctl start ufw.service
sudo ufw deny 22/tcp

# Bonus: Setup AutoCpuFreq for power management (for laptops)
yay -Sy auto-cpufreq --noconfirm
sudo systemctl enable auto-cpufreq.service
