#!/usr/bin/env sh

# install tpm

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install base16

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# install doom emacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync
