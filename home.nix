{ config, pkgs, lib, ... }:

{
  home.username = "igor";
  home.homeDirectory = "/home/igor";
  #home.stateVersion = "24.05";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.fzf
    pkgs.picom
    pkgs.zsh
    pkgs.dunst
    pkgs.rofi
    pkgs.feh
    pkgs.direnv
    pkgs.xscreensaver
    pkgs.xbanish
    pkgs.redshift
    pkgs.libnotify
    pkgs.chromium
    pkgs.ripgrep
    pkgs.tmux
    pkgs.tmuxinator
    pkgs.pandoc
    pkgs.devenv
    #pkgs.alacritty
    pkgs.kitty
    #pkgs.agda
    #pkgs.agdaPackages.standard-library
    pkgs.tor-browser-bundle-bin
    (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })
    pkgs.nix-tree
    pkgs.mpv
  ];


  xsession = {
    enable = true;
    windowManager.command = "xmonad";
    initExtra = "
      setxkbmap br
      setxkbmap -option ctrl:swapcaps
      xset r rate 250 60
      xset fp+ ~/.nix-profile/share/fonts/truetype/NerdFonts
      feh --bg-fill ~/bg.png

      #picom --config ~/.picom.conf & disown
      dunst & disown
      xscreensaver & disown
      xbanish & disown
      acpinot & disown
      redshift -l 10.5:37.4 -t 5700:4000 -b 1.0:0.6 -g 0.8 -m randr -v & disown
    ";
  };

  imports = [ ./zsh.nix ];

  home.file = {
    ".tmux.conf".source = dotfiles/tmux.conf;
    ".xmonad/xmonad.hs".source = dotfiles/xmonad.hs;
    ".fzf.env".source = dotfiles/fzf.env;
    ".picom.conf".source = dotfiles/picom.conf;
    ".xinitrc".source = dotfiles/xinitrc;
    ".zshrc".source = dotfiles/zshrc;
    ".cwmrc".source = dotfiles/cwmrc;
    ".vimrc".source = dotfiles/vimrc;

    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore_global".source = dotfiles/gitignore_global;

    ".config/dunst/dunstrc".source = dotfiles/dunstrc;
    ".config/rofi/config.rasi".source = dotfiles/config.rasi;
    ".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;
    ".config/alacritty/alacritty-white.toml".source = dotfiles/alacritty-white.toml;

    ".scripts/install-manual.sh".source = dotfiles/install-manual.sh;
    ".scripts/pomo.sh".source = dotfiles/pomo.sh;
    ".scripts/kitty.sh".source = dotfiles/kitty.sh;
    ".scripts/al-white".source = dotfiles/al-white;

    "bg.png".source = dotfiles/bg.png;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
