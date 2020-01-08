#!/usr/bin/env bash
#
# This is an installation-script for my personal Arch-Linux setup.

USERNAME=tim

echo arch > /etc/hostname
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf

# Generate locales
sed -i 's/#de_DE.UTF-8/de_DE.UTF-8/' /etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# Make initramfs
echo -e "\nBuilding initramfs..."
mkinitcpio -p linux

echo -e "\nSet root-password:"
passwd

# Install packages
echo -e "\nInstalling packages..."
pacman -S --noconfirm \
    grub \
    xorg \
    xorg-xinit \
    xf86-video-intel \
    alsa-utils \
    fish \
    ranger \
    htop \
    ncdu \
    fzf \
    bat \
    fd \
    ripgrep \
    tar \
    clang \
    shellcheck \
    cups \
    gparted \
    vim \
    neovim \
    julia \
    python-pandas \
    python-numpy \
    python-matplotlib \
    python-scikit-learn \
    python-scipy \
    jupyter \
    python-jupyter_core \
    python-jupyter_client \
    jupyterlab \
    zathura \
    libreoffice-fresh \
    firefox \
    alacritty \
    thunderbird \
    plasma \
    kcolorchooser \
    okular \
    dolphin \
    spectacle \
    gwenview \
    kdeconnect \
    ktimer \
    kalarm \
    git \
    cmake \
    extra-cmake-modules \
    qt5 \
    texlive-most \
    networkmanager \
    qemu \
    libvirt \
    # virsh \
    virt-manager

# Make User
echo -e "\nAdd user..."
useradd -m $USERNAME
echo -e "\nEnter password for user {$USERNAME}:"
passwd $USERNAME
usermod -aG wheel,audio,video,optical,storage tim
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL(ALL)= ALL/' /etc/sudoers

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo 'exec startplasma-x11' > /home/tim/.xinitrc

exit 0
