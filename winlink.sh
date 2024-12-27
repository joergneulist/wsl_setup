#!/bin/bash

BATCH_DIR='~/winhome/bin'
. /etc/os-release
WSL_PATH='\\wsl.localhost\'$NAME

win_path() {
	echo $WSL_PATH$(readlink -f "$1"|sed 's#/#\\#g')
}


while [[ $# -gt 0 ]]
do
	case $1 in
		'-i')
			ICON="$2"
			shift 2
			;;
		'-c')
			CMDNAME="$2"
			shift 2
			;;
		*)
			break
	esac
done
COMMAND="$*"

mkdir -p $BATCH_DIR
echo "wsl -- $COMMAND" >>$BATCH_DIR/$CMDNAME.bat

TARGET="$(win_path $BATCH_DIR/$CMDNAME.bat)"
ICON="$(win_path $ICON)"
./mslink_v1.3.sh -l $TARGET -n $CMDNAME -i $ICON -o ~/'winhome/AppData/Roaming/Microsoft/Windows/Start Menu/Programs'/$CMDNAME.lnk
