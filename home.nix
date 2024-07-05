{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "igor";
  home.homeDirectory = "/home/igor";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    #pkgs.base16
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
    pkgs.chromium

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })

    (pkgs.st.overrideAttrs (oldAttrs: rec {
    configFile = pkgs.writeText "config.def.h" (builtins.readFile ./dotfiles/config.h);
    postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
    }))

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

      picom --config ~/.picom.conf & disown
      emacs --daemon & disown
      dunst & disown
      xscreensaver & disown
      xbanish & disown
      acpinot & disown
      redshift -l 10.5:37.4 -t 5700:2500 -g 0.8 -m randr -v & disown
    ";
  };

  imports = [ ./zsh.nix ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

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

    ".scripts/install-manual.sh".source = dotfiles/install-manual.sh;
    ".scripts/pomo.sh".source = dotfiles/pomo.sh;

    "bg.png".source = dotfiles/bg.png;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/igor/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
