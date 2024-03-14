#/bin/sh

_arr=($(ls --sort=time *.tar.xz))
unxz $_arr && tar --overwrite xvPf ${_arr%".xz"}
