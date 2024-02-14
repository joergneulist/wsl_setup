#!/bin/bash

BASE=$(readlink -f $(dirname $0))
source $BASE/config

write_env_loader() 
{
    echo 'export BROWSER="'$BROWSER'"'
    echo 'for f in $BASE/.env.d/*'
    echo 'do'
    echo '    source $f'
    echo 'done'
}

write_jupyter_loader()
{
    echo 'export BROWSER="'$BROWSER'"'
    echo 'export JUPYTER_ENV='$JUPYTER_ENV
    cat $BASE/files/.run_jupyter.sh
}

echo '###################### UPDATE SYSTEM'
sudo $BASE/.install_root.sh $(whoami)
ln -s /mnt/c/users/$WIN_USER ~/winhome

echo '###################### CONFIGURE GIT'
git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

echo '###################### CONFIGURE JUPYTER'
poetry new $JUPYTER_ENV
pushd $JUPYTER_ENV
poetry add ipykernel jupyter pandas
poetry install
install -D -t ~/.jupyter $BASE/files/jupyter_lab_config.py
write_jupyter_loader > ~/.run_jupyter.sh
chmod a+x ~/.run_jupyter.sh
popd

echo '###################### INSTALL OH-MYZSH'
INSTALLER=$(mktemp)
curl -fsSLo $INSTALLER https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod a+x $INSTALLER
ZSH=$OMZ_DIR $INSTALLER --unattended
write_env_loader > $OMZ_DIR/custom/env.zsh

