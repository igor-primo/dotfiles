#/bin/sh

# Programs:
# dunst
# emacs
# rofi
# picom
# spectrwm
# neovim

_destfile="./dotfiles-$(date +%F).tar"

# Configs
_arr=("/home/$USER/.config/dunst/dunstrc")
_arr+=("/home/$USER/.config/rofi/config.rasi")
_arr+=("/home/$USER/.picom.conf")
_arr+=("/home/$USER/.cwmrc")
_arr+=("/home/$USER/.emacs.d/init.el")
_arr+=("/home/$USER/.xinitrc")
_arr+=("/home/$USER/.Xresources")
_arr+=("/home/$USER/.spectrwm.conf")
_arr+=("/home/$USER/.tmux.conf")
_arr+=("/home/$USER/.config/nvim/")

# Bins
_arr+=("/home/$USER/bg.jpg")

# Scripts
_arr+=($(find /home/$USER/scripts))

rm *.tar >/dev/null ; rm *.tar.xz >/dev/null

tar cvPf $_destfile ${_arr[@]} \
	&& xz -9 $_destfile \
	&& git add . \
	&& git commit -m 'atualização' \
	&& git push
