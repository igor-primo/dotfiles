#/bin/sh

_arr=($(ls --sort=time *.tar.xz))
unxz $_arr && tar xvPf ${_arr%".xz"}
