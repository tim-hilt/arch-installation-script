#!/usr/bin/env bash
#
# Post-Installation-Script

USERNAME=tim

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

mkdir /home/"$USERNAME"/git/

# Setting up AUR
echo -e "\nSetting up AUR..."
git clone https://aur.archlinux.org/yay.git /home/"$USERNAME"/git/yay/
cd /home/"$USERNAME"/yay || exit 1
makepkg -si
cd || exit 1

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

# Install hello-theme for KDE
echo -e "\nInstall hello KDE theme"
git clone https://github.com/n4n0GH/hello /home/"$USERNAME"/git/hello/
cd /home/"$USERNAME"/git/hello/ || exit 1
mkdir ./build
cd ./build/ || exit 1
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install
cd || exit 1
