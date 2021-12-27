#!/bin/bash

PACKAGES=grml-zsh-config jupyterlab sudo vim
_USER=joerg
_SHELL=/usr/bin/zsh
USER_EMAIL="joerg@neulist.de"
USER_NAME="Joerg Neulist"

pacman-key --init
pacman-key --populate
pacman-key --refresh-keys
pacman -Sy archlinux-keyring
pacman -Syu base-devel git jupyterlab python-pip python-virtualenv $PACKAGES

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
useradd -m -G wheel -s $_SHELL $_USER
passwd $_USER
su -l $_USER

git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

ln -s /mnt/c/users/$_USER ~/winhome

pip install jupyterlab-git jupyterlab-tabnine nbdime pip_magic
nbdime config-git --enable --global
mkdir -p ~/jupyter/repos

mkdir -p ~/repos
cd ~/repos
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -Syu python3.9

# Uncomment if systemd is needed
#yay -S genie-systemd-git
