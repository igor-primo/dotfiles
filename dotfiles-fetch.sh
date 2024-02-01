#/bin/sh

# Programs:
# dunst
# 2bwm
# emacs
# rofi
# picom

_destfile="./dotfiles-$(date +%F).tar"

# Configs
_arr=("/home/$USER/.config/dunst/dunstrc")
_arr+=("/home/$USER/.config/rofi/config.rasi")
_arr+=("/home/$USER/repos/2bwm/config.h")
_arr+=("/home/$USER/.picom.conf")
_arr+=("/home/$USER/.emacs.d/init.el")
_arr+=("/home/$USER/.xinitrc")
_arr+=("/home/$USER/.Xresources")

# Bins
_arr+=("/home/$USER/bg.jpg")

# Scripts
_arr+=($(find /home/$USER/scripts))

tar cvPf $_destfile ${_arr[@]} && git add . && git commit -m 'atualização' && git push
