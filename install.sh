#!/bin/bash

BASE=$(readlink -f $(dirname $0))
source "$BASE"/config

win_path()
{
	echo "C:/Users/$WIN_USER/$*" | sed 's#/#\\#g'
}

write_env_loader() 
{
    echo 'export BROWSER="'$BROWSER'"'
    echo 'for f in '$BASE'/.env.d/*'
    echo 'do'
    echo '    source $f'
    echo 'done'
}

write_jupyter_loader()
{
    echo 'export BROWSER="'$BROWSER'"'
    echo 'export JUPYTER_ENV='$JUPYTER_ENV
    cat "$BASE/files/.run_jupyter.sh"
}

make_link()
{
	NAME="$1"
	DESC="$2"
	COMMAND="$3"
	ICON="$4"
	
	TARG_BAT="$WIN_BIN/$NAME.bat"
	LIN_BAT=~/winhome/"$TARG_BAT"
	WIN_BAT="$(win_path $TARG_BAT)"
	
	TARG_ICO="$WIN_ICONS/$NAME.ico"
	LIN_ICO=~/winhome/"$TARG_ICO"
	WIN_ICO="$(win_path $TARG_ICO)"

	TARG_LNK="$WIN_LINKS/$DESC.lnk"
	LIN_LNK=~/winhome/"$TARG_LNK"

	cp "$ICON" "$LIN_ICO"
	echo 'wsl -- '"$COMMAND" >"$LIN_BAT"
	$BASE/mslink_v1.3.sh -n "Jupyter Lab" -l "$WIN_BAT" -i "$WIN_ICO" -o "$LIN_LNK"
}

echo '###################### UPDATE SYSTEM'
sudo "$BASE/.install_root.sh" $(whoami)
ln -s "/mnt/c/users/$WIN_USER" ~/winhome
mkdir -p ~/winhome/"$WIN_BIN" ~/winhome/"$WIN_ICO"
pip install poetry vmd

echo '###################### CONFIGURE GIT'
git config --global credential.helper store
git config --global pull.rebase true
git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"

echo '###################### CONFIGURE JUPYTER'
poetry new "$JUPYTER_ENV"
pushd "$JUPYTER_ENV"
poetry add ipykernel jupyter pandas
poetry install
install -D -t ~/.jupyter "$BASE/files/jupyter_lab_config.py"
write_jupyter_loader > ~/.run_jupyter.sh
chmod a+x ~/.run_jupyter.sh
popd
make_link jupyterlab "Jupyter Lab" ".run_jupyter.sh" "$BASE/files/jupyterlab.ico"

echo '###################### INSTALL OH-MYZSH'
INSTALLER="$(mktemp)"
curl -fsSLo "$INSTALLER" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod a+x "$INSTALLER"
ZSH="$OMZ_DIR" "$INSTALLER" --unattended
write_env_loader > "$OMZ_DIR/custom/env.zsh"

