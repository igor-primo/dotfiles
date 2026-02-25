{ config, pkgs, lib, inputs, ... }:

{
  home.username = "igor";
  home.homeDirectory = "/home/igor";
  home.stateVersion = "25.05";

  home.packages = [
    pkgs.zsh # The glorious shell
    pkgs.nushell # The functional shell
    pkgs.atuin # The glorious shell history everything
    pkgs.fzf # The glorious text finder
    pkgs.ripgrep # The glorious grepper
    pkgs.bat # The glorious cat
    pkgs.eza # The glorious ls
    pkgs.fd # The glorious find
    pkgs.zoxide # Better dirs
    pkgs.yazi # File manager
    pkgs.starship # Ma prompt
    #pkgs.direnv # managed by programs.direnv below
    pkgs.devenv # It's wrapper
    pkgs.tmux # The glorious terminal multiplexer
    pkgs.zellij # Tmux dethroned?
    pkgs.lazygit # The glorious git frontend
    pkgs.gitui # Another one
    pkgs.btop # The glorious terminal system monitor
    #(pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })# The glorious font
    #pkgs.mpv                                                # ???
    pkgs.strace # Handy for debugging native bins
    pkgs.inotify-tools # Handy for creating feedback loops when lsp is not possible
    pkgs.gdb # The trad native debugger
    pkgs.radare2 # The glorious native debugger
    pkgs.taskwarrior3 # Task management with details
    pkgs.khal # Agenda app
    pkgs.jrnl # A journaling app
    pkgs.cargo # In order to install some ad-hoc rust programs
    pkgs.feh # Images
    #pkgs.timer                                              # A timer
    pkgs.gh # Github on CLI :)
    pkgs.act # Run Github Actions locally
    pkgs.dunst
    pkgs.lazydocker # Sane Docker
    pkgs.neomutt # Sane e-mail
    pkgs.isync # Sane e-mail synchronizer
    pkgs.elinks # Sane browser
    pkgs.w3m # Sane browser
    pkgs.universal-ctags
    #pkgs.fourmolu #too old
    #pkgs.gnucash
    pkgs.kubectl
    pkgs.awscli2
    pkgs.postgresql
    pkgs.k9s
    pkgs.pandoc
    pkgs.jira-cli-go
    pkgs.terraform
    pkgs.kind
    pkgs.helmfile
    pkgs.kubernetes-helm
    pkgs.ngrok
    pkgs.lorri
    pkgs.carapace
    pkgs.actionlint
    pkgs.calcurse
    #pkgs.newsboat
    #pkgs.pipe-viewer
    pkgs.xbanish
    pkgs.flameshot
    pkgs.picom
    #pkgs.fish # managed by programs.fish below
    inputs.nixvim.packages."x86_64-linux".default
    inputs.llm-agents.packages."x86_64-linux".copilot-cli

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

  #imports = [ ./zsh.nix ];

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
    ".scripts/remember.sh".source = dotfiles/remember.sh;
    ".scripts/external_keyboard_script.sh".source = dotfiles/external_keyboard_script.sh;

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      f = "fg";
      ls = "eza --long --header --git --reverse --sort=size --icons=always";
      tree = "eza --long --header --git --reverse --sort=size --tree --icons=always";
      y = "yazi";
      n = "nvim";
      t = "tmux";
      lg = "lazygit";
      ta = "tmux a";
      nw = "newsboat";
      pv = "pipe-viewer -7";
      pva = "pipe-viewer -7 --no-video";
    };
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
    interactiveShellInit = ''
      ${pkgs.zoxide}/bin/zoxide init fish | source
    '';
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
