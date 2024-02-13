#!/bin/bash

apt update
apt dist-upgrade -y
apt install -y bat exa python3-poetry zsh
chsh $1 -s /usr/bin/zsh
