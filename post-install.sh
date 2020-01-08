#!/usr/bin/env bash

# Enable systemd-services
systemctl start NetworkManager
systemctl enable NetworkManager
systemctl start bluetooth
systemctl enable bluetooth
systemctl start org.cups.cupsd
systemctl enable org.cups.cupsd

# Make fish the default shell
chsh -s "$(command -v fish)"

# Make AUR usable
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si

# Install AUR-packages
yay -S --noconfirm \
    emacs-git-shallow \
    balena-etcher \
    spotify \
    insync \
    yadm

 # Install Doom-Emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d/
~/.emacs.d/bin/doom install
rm -rf ~/.doom.d/
git clone https://github.com/tim-hilt/.doom.d ~/.doom.d/
