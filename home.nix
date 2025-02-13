{ config, pkgs, lib, ... }:

{
  home.username = "igor";
  home.homeDirectory = "/home/igor";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.neovim                                             # The glorious text editor
    pkgs.zsh                                                # The glorious shell
    pkgs.nushell                                            # The functional shell
    pkgs.atuin                                              # The glorious shell history everything
    pkgs.fzf                                                # The glorious text finder
    pkgs.ripgrep                                            # The glorious grepper
    pkgs.bat                                                # The glorious cat
    pkgs.eza                                                # The glorious ls
    pkgs.fd                                                 # The glorious find
    pkgs.zoxide                                             # Better dirs
    pkgs.yazi                                               # File manager
    pkgs.starship                                           # Ma prompt
    pkgs.direnv                                             # The glorious shell env manager
    pkgs.devenv                                             # It's wrapper
    pkgs.tmux                                               # The glorious terminal multiplexer
    pkgs.zellij                                             # Tmux dethroned?
    pkgs.lazygit                                            # The glorious git frontend
    pkgs.gitui                                              # Another one
    pkgs.btop                                               # The glorious terminal system monitor
    #(pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })# The glorious font
    pkgs.mpv                                                # ???
    pkgs.strace                                             # Handy for debugging native bins
    pkgs.inotify-tools                                      # Handy for creating feedback loops when lsp is not possible
    pkgs.gdb                                                # The trad native debugger
    pkgs.radare2                                            # The glorious native debugger
    pkgs.taskwarrior3                                       # Task management with details
    pkgs.khal                                               # Agenda app
    pkgs.jrnl                                               # A journaling app
    pkgs.cargo                                              # In order to install some ad-hoc rust programs
    pkgs.feh                                                # Images
    pkgs.timer                                              # A timer
    pkgs.gh                                                 # Github on CLI :)
    pkgs.act                                                # Run Github Actions locally
    pkgs.dunst
    pkgs.lazydocker                                         # Sane Docker
    pkgs.neomutt                                            # Sane e-mail
    pkgs.isync                                              # Sane e-mail synchronizer
    pkgs.elinks                                             # Sane browser
    pkgs.w3m                                             # Sane browser
    pkgs.ollama                                             # Sane browser

    # Hyprland / Wayland (For the time being managed by distribution)
    #pkgs.hyprland
    #pkgs.waybar
    #pkgs.kitty
    #pkgs.wofi
    #pkgs.hyprpaper
    #pkgs.hyprlock
    #pkgs.hypridle
    pkgs.hyprshot
    #pkgs.wlsunset
  ];

  imports = [ ./zsh.nix ];

  # Install dijo
  # Install wasp
  # Install x-cmd
  # Install base16

  home.file = {
    ".tmux.conf".source = dotfiles/tmux.conf;
    ".fzf.env".source = dotfiles/fzf.env;
    ".zshrc".source = dotfiles/zshrc;
    ".vimrc".source = dotfiles/vimrc;
    ".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;
    ".config/kitty/kitty.conf".source = dotfiles/kitty.conf;
    ".config/hypr".source = dotfiles/hypr;
    ".config/waybar".source = dotfiles/waybar;
    ".config/wofi".source = dotfiles/wofi;

    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore_global".source = dotfiles/gitignore_global;

    ".scripts/install-manual.sh".source = dotfiles/install-manual.sh;

    # The following are, probably, legacy.
    ".wallpapers".source = ./wallpapers;
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
