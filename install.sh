#!/bin/sh

git pull

FILES=".spectrwm.conf"
FILES="$FILES .vimrc"
FILES="$FILES .bashrc"
FILES="$FILES .profile"
FILES="$FILES .curlrc"
FILES="$FILES .scripts"
FILES="$FILES .source"
FILES="$FILES .tmux.conf"
FILES="$FILES .xinitrc"

cp -r $FILES $HOME/
