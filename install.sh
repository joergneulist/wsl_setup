#!/bin/bash

BASE=$(readlink -f $(dirname $0))
source $BASE/config

echo '###################### UPDATE SYSTEM'
sudo $BASE/.install_root.sh $(whoami)
ln -s /mnt/c/users/$WIN_USER ~/winhome

echo '###################### CONFIGURE GIT'
git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

echo '###################### CONFIGURE JUPYTER'
poetry new $JUPY_DIR
pushd $JUPY_DIR
poetry add ipykernel jupyter pandas $JUPYTER_EXT
poetry install
install -D -t ~/.jupyter $BASE/files/jupyter_lab_config.py
popd

echo '###################### INSTALL OH-MYZSH'
INSTALLER=$(mktemp)
curl -fsSLo $INSTALLER https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod a+x $INSTALLER
ZSH=$OMZ_DIR $INSTALLER --unattended
echo "for f in $BASE/.env.d/*; do source \$f; done" > $OMZ_DIR/custom/env.zsh
