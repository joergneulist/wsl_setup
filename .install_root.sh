#!/bin/bash

apt update
apt dist-upgrade -y
apt install -y bat eza fish neovim python3 python3-poetry
chsh $1 -s $USER_SHELL
