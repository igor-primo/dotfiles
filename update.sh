#!/bin/sh

FILES="$HOME/.spectrwm.conf"
FILES="$FILES $HOME/.vimrc"
FILES="$FILES $HOME/.bashrc"
FILES="$FILES $HOME/.profile"
FILES="$FILES $HOME/.curlrc"
FILES="$FILES $HOME/.scripts"
FILES="$FILES $HOME/.source"
FILES="$FILES $HOME/.tmux.conf"
FILES="$FILES $HOME/.xinitrc"

cp -r $FILES ./

git add . && git commit -m 'update' && git push
