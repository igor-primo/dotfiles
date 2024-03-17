#!/bin/sh

_dir="/home/igor/repos"

_eza_repo="https://github.com/eza-community/eza"
_fzf_repo="https://github.com/junegunn/fzf"
_ripgrep_repo="https://github.com/BurntSushi/ripgrep"
_bat_repo="https://github.com/sharkdp/bat"
_fd_repo="https://github.com/sharkdp/fd"

_base16_shell_repo="https://github.com/chriskempson/base16-shell"
_tpm_repo="https://github.com/tmux-plugins/tpm"
_tmux_repo="https://github.com/tmux/tmux"

cd $_dir

alias clone="git clone"

# install eza

[ ! -d eza ] && \
  clone $_eza_repo && \
  cd eza && \
  cargo install --path . ; \
  [ $(pwd) = "$_dir/eza" ] && \
  cd ..

# install fzf

[ ! -d fzf ] && \
  clone $_fzf_repo && \
  cd fzf && \
  make && make install ; \
  [ $(pwd) = "$_dir/fzf" ] && \
  cd ..

# install ripgrep

[ ! -d ripgrep ] && \
  clone $_ripgrep_repo && \
  cd ripgrep && \
  cargo build --release && \
  cargo test --all && \
  cargo install --path . ; \
  [ $(pwd) = "$_dir/ripgrep" ] && \
  cd ..

# install bat

[ ! -d bat ] && \
  clone $_bat_repo && \
  cd bat && \
  cargo install --locked bat ; \
  [ $(pwd) = "$_dir/bat" ] && \
  cd ..

# install fd

[ ! -d fd ] && \
  clone $_fd_repo && \
  cd fd && \
  cargo build && \
  cargo test && \
  cargo install --path . ; \
  [ $(pwd) = "$_dir/fd" ] && \
  cd ..

# install base16_shell

[ ! -d ~/.config/base16-shell ] && \ 
  clone $_base16_shell_repo ~/.config/base16-shell

# install tpm

[ ! -d ~/.tmux/plugins/tpm ] && \
  clone $_tpm_repo ~/.tmux/plugins/tpm

# install tmux

[ ! -d tmux ] && \
  clone $_tmux_repo && \
  cd tmux && \
  sh autogen.sh && \
  configure && \
  make -j4 ; \
  [ $(pwd) = "$_dir/fd" ] && \
  cd ..
