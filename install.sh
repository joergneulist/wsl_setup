#!/bin/bash

sudo .install_root.sh

BASE=$(readlink -f $(dirname $0))
source $BASE/config

git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

ln -s /mnt/c/users/$WIN_USER ~/winhome

install -D -t ~/.jupyter $BASE/files/jupyter_lab_config.py

poetry new $JUPY_DIR
pushd $JUPY_DIR
poetry add ipykernel jupyter pandas $JUPYTER_EXT
poetry install
popd

INSTALLER=$(mktemp)
curl -fsSLo $INSTALLER https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod a+x $INSTALLER
ZSH=$OMZ_DIR $INSTALLER --unattended
echo "for f in $BASE/.env.d/*; do source \$f; done" > $OMZ_DIR/custom/custom_env.zsh

#IP==$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
#touch ~/.Xauthority
#xauth add $IP:0.0 . $(dd if=/dev/random bs=1024 count=1 of=/dev/stdout 2>/dev/null | md5sum | cut -f1 -d\ )
#cp ~/.Xauthority ~/winhome/
