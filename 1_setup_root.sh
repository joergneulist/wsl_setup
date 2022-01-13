#!/bin/bash

source $(dirname $0)/config

pacman-key --init
pacman-key --populate
pacman-key --refresh-keys
pacman -Sy archlinux-keyring
pacman -Syu base-devel git jupyterlab nodejs npm python-pip python-virtualenv xorg-xauth $PACKAGES
jupyter labextension install jupyterlab-plotly @jupyter-widgets/jupyterlab-manager plotlywidget

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
useradd -m -G wheel -s $USER_SHELL $LIN_USER
passwd $LIN_USER
su -l $LIN_USER
