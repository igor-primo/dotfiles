{ config, pkgs, lib, ... }:

{
  home.username = "igor";
  home.homeDirectory = "/home/igor";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.neovim                                             # The glorious text editor
    pkgs.zsh                                                # The glorious shell
    pkgs.fzf                                                # The glorious text finder
    pkgs.ripgrep                                            # The glorious grepper
    pkgs.bat                                                # The glorious cat
    pkgs.eza                                                # The glorious ls
    pkgs.fd                                                 # The glorious find
    pkgs.zoxide                                             # Better dirs
    pkgs.starship                                           # Ma prompt
    pkgs.direnv                                             # The glorious shell env manager
    pkgs.devenv                                             # It's wrapper
    pkgs.tmux                                               # The glorious terminal multiplexer
    pkgs.btop                                               # The glorious terminal system monitor
    (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })# The glorious font
    pkgs.mpv                                                # ???
    pkgs.strace                                             # Handy for debugging native bins
    pkgs.inotify-tools                                      # Handy for creating feedback loops when lsp is not possible
    pkgs.gdb                                                # The trad native debugger
    pkgs.radare2                                            # The glorious native debugger
    pkgs.taskwarrior3                                       # Task management with details
    pkgs.khal                                               # Agenda app
    pkgs.jrnl                                               # A journaling app
    pkgs.cargo                                              # In order to install some ad-hoc rust programs
  ];

  imports = [ ./zsh.nix ];

  # Install dijo
  # Install wasp

  home.file = {
    ".tmux.conf".source = dotfiles/tmux.conf;
    ".fzf.env".source = dotfiles/fzf.env;
    ".zshrc".source = dotfiles/zshrc;
    ".vimrc".source = dotfiles/vimrc;
    ".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;

    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore_global".source = dotfiles/gitignore_global;

    ".scripts/install-manual.sh".source = dotfiles/install-manual.sh;

    # The following are, probably, legacy.
    "bg.png".source = dotfiles/bg.png;
    ".xmonad/xmonad.hs".source = dotfiles/xmonad.hs;
    ".picom.conf".source = dotfiles/picom.conf;
    ".xinitrc".source = dotfiles/xinitrc;
    ".cwmrc".source = dotfiles/cwmrc;
    ".config/dunst/dunstrc".source = dotfiles/dunstrc;
    ".config/rofi/config.rasi".source = dotfiles/config.rasi;
    ".scripts/pomo.sh".source = dotfiles/pomo.sh;
    ".scripts/kitty.sh".source = dotfiles/kitty.sh;
    ".scripts/al-white".source = dotfiles/al-white;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
