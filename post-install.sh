#!/usr/bin/env bash
#
# Post-Installation script

# Enable systemd-services
echo -e "\nEnabling systemd-services..."
systemctl start NetworkManager
systemctl enable NetworkManager
systemctl start bluetooth
systemctl enable bluetooth
systemctl start org.cups.cupsd
systemctl enable org.cups.cupsd

# Make fish the default shell
echo -e "\nSwitching default shell to fish..."
chsh -s "$(command -v fish)"

# Setting up AUR
echo -e "\nSetting up AUR..."
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si

# Install AUR-packages
echo -e "\nInstalling AUR-packages..."
yay -S --noconfirm \
    emacs-git-shallow \
    balena-etcher \
    spotify \
    insync \
    yadm

 # Install Doom-Emacs
 echo -e "\nInstall doom-emacs"
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d/
~/.emacs.d/bin/doom install
rm -rf ~/.doom.d/
git clone https://github.com/tim-hilt/.doom.d ~/.doom.d/
