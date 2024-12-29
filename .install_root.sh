#!/bin/bash

apt update
apt dist-upgrade -y
apt install -y bat eza python3 python3-pip python3-poetry zsh
chsh $1 -s /usr/bin/zsh
