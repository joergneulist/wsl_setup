#!/bin/bash

source $(dirname $0)/config

git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

ln -s /mnt/c/users/$WIN_USER ~/winhome

pip install jupyterlab-git jupyterlab-tabnine nbdime pip_magic
nbdime config-git --enable --global
mkdir -p ~/jupyter/repos

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

yay -Syu code-server exa oh-my-zsh-git python39
mkdir -p ~/.local/venv

IP==$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
touch ~/.Xauthority
xauth add $IP:0.0 . $(dd if=/dev/random bs=1024 count=1 of=/dev/stdout 2>/dev/null | md5sum | cut -f1 -d\ )
cp ~/.Xauthority ~/winhome/

# Uncomment if systemd is needed
#yay -S genie-systemd-git
