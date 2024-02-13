#!/bin/bash

BASE=$(readlink -f $(dirname $0))

source $BASE/config

git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

ln -s /mnt/c/users/$WIN_USER ~/winhome

install -D -t ~/.jupyter $BASE/install/jupyter_lab_config.py

poetry new $JUPY_DIR
pushd $JUPY_DIR
poetry add ipykernel jupyter pandas $JUPYTER_EXT
poetry install
popd

# OH MY ZSH
# ZSH=~/$OMZ_DIR
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# echo "for f in $BASE/.env.d/\*
#do
#        source $f
#done" > ~/$OMZ_DIR/custom/custom_env.zsh


#IP==$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
#touch ~/.Xauthority
#xauth add $IP:0.0 . $(dd if=/dev/random bs=1024 count=1 of=/dev/stdout 2>/dev/null | md5sum | cut -f1 -d\ )
#cp ~/.Xauthority ~/winhome/
