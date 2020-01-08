#!/usr/bin/env bash
#
# This is an installation-script for my personal Arch-Linux setup.

USER=tim

echo arch > /etc/hostname
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf

# Generate locales
sed -i 's/#de_DE.UTF-8/de_DE.UTF-8/' /etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

mkinitcpio -p linux
echo "Set root-password:"
passwd

# Install packages
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
    zathura \
    libreoffice-fresh \
    firefox \
    alacritty \
    thunderbird \
    plasma \
    kcolorchooser \
    okular \
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

useradd -m $USER
echo "Enter password for user $USER"
passwd tim
usermod -aG wheel,audio,video,optical,storage tim
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL(ALL)= ALL/' /etc/sudoers

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo 'exec startplasma-x11' > /home/tim/.xinitrc

mkdir /home/tim/git/
cd /home/tim/git/ || exit
git clone https://github.com/n4n0GH/hello
cd hello || exit
mkdir build
cd build || exit
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
make install
cd / || exit
