{ config, pkgs, lib, ... }:

{
  home.username = "igor";
  home.homeDirectory = "/home/igor";
  home.stateVersion = "24.05";

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
    pkgs.emacs
    pkgs.libnotify
    pkgs.firefox
    pkgs.chromium
    pkgs.ripgrep
    pkgs.lorri
    pkgs.tmux
    pkgs.tmuxinator
    pkgs.pandoc
    pkgs.devenv
    pkgs.vscodium
    pkgs.alacritty
    pkgs.kitty
    pkgs.tor-browser-bundle-bin
    (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })

    (pkgs.st.overrideAttrs (oldAttrs: rec {
      configFile = pkgs.writeText "config.def.h" (builtins.readFile ./dotfiles/config.h);
      postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
    }))

    (builtins.getFlake "path:/home/igor/repos/nixvim").packages.x86_64-linux.default
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
    ".base16.env".source = dotfiles/base16.env;
    ".fzf.env".source = dotfiles/fzf.env;
    ".picom.conf".source = dotfiles/picom.conf;
    ".xinitrc".source = dotfiles/xinitrc;
    ".zshrc".source = dotfiles/zshrc;
    ".cwmrc".source = dotfiles/cwmrc;
    ".spectrwm.conf".source = dotfiles/spectrwm.conf;
    ".vimrc".source = dotfiles/vimrc;
    ".xmobarrc".source = dotfiles/xmobarrc;

    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore_global".source = dotfiles/gitignore_global;

    ".config/dunst/dunstrc".source = dotfiles/dunstrc;
    ".config/rofi/config.rasi".source = dotfiles/config.rasi;

    ".config/doom/config.el".source = dotfiles/doom/config.el;
    ".config/doom/custom.el".source = dotfiles/doom/custom.el;
    ".config/doom/init.el".source = dotfiles/doom/init.el;
    ".config/doom/packages.el".source = dotfiles/doom/packages.el;
    ".config/doom/koma.el".source = dotfiles/doom/koma.el;

    ".scripts/install-manual.sh".source = dotfiles/install-manual.sh;
    ".scripts/pomo.sh".source = dotfiles/pomo.sh;
    ".scripts/kitty.sh".source = dotfiles/kitty.sh;

    "bg.png".source = dotfiles/bg.png;
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
