#!/usr/bin/env bash
#
# This is an installation-script for my personal Arch-Linux setup.

echo arch > /etc/hostname
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf

sed -i 's/#de_DE.UTF-8/de_DE.UTF-8/' /etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

mkinitcpio -p linux
passwd

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
    yadm \
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
    virsh \
    virt-manager

git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si

yay -S --noconfirm \
    emacs-git-shallow \
    balena-etcher \
    spotify \
    insync

useradd -m tim
passwd tim
usermod -aG wheel,audio,video,optical,storage tim
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL(ALL)= ALL/' /etc/sudoers

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl start NetworkManager
systemctl enable NetworkManager
systemctl start bluetooth
systemctl enable bluetooth
systemctl start org.cups.cupsd
systemctl enable org.cups.cupsd

echo 'exec startplasma-x11' > /home/tim/.xinitrc

mkdir /home/tim/git/
cd /home/tim/git/ || exit
git clone https://github.com/n4n0GH/hello
cd hello || exit
mkdir build
cd build || exit
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install
cd / || exit
