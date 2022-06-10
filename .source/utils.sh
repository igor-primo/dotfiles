#!/bin/bash

export PATH=$PATH:/home/igor/.local/bin
export PATH=$PATH:/home/igor/.local/lib
export PATH=$PATH:/home/igor/.local/share
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/sbin
export PATH=$PATH:/home/igor/.scripts
export PATH=$PATH:/home/igor/repos/commandline-breviary
export PATH=$PATH:/opt/lampp/bin
export EDITOR=vim

alias poweroff="doas /sbin/poweroff"
alias reboot="doas /sbin/reboot"
alias mpv="mpv --ytdl-format=best"
alias yt=pipe-viewer
alias focus="doas /home/igor/hosts/hfocus"
alias cout="xclip -selection clipboard -o"
alias cin="xclip -selection clipboard -i"
alias top="top -d 0.5"
