{ config, pkgs, lib, inputs, ... }:

{
  home.username = "igor";
  home.homeDirectory = "/home/igor";
  home.stateVersion = "25.05";

  home.packages = with pkgs;[
    zsh # The glorious shell
    nushell # The functional shell
    atuin # The glorious shell history everything
    fzf # The glorious text finder
    ripgrep # The glorious grepper
    bat # The glorious cat
    eza # The glorious ls
    fd # The glorious find
    zoxide # Better dirs
    yazi # File manager
    starship # Ma prompt
    #direnv # managed by programs.direnv below
    devenv # It's wrapper
    tmux # The glorious terminal multiplexer
    zellij # Tmux dethroned?
    lazygit # The glorious git frontend
    gitui # Another one
    btop # The glorious terminal system monitor
    #(nerdfonts.override { fonts = [ "Inconsolata" ]; })# The glorious font
    #mpv                                                # ???
    strace # Handy for debugging native bins
    inotify-tools # Handy for creating feedback loops when lsp is not possible
    gdb # The trad native debugger
    radare2 # The glorious native debugger
    taskwarrior3 # Task management with details
    khal # Agenda app
    jrnl # A journaling app
    cargo # In order to install some ad-hoc rust programs
    feh # Images
    #timer                                              # A timer
    gh # Github on CLI :)
    act # Run Github Actions locally
    dunst
    lazydocker # Sane Docker
    neomutt # Sane e-mail
    isync # Sane e-mail synchronizer
    elinks # Sane browser
    w3m # Sane browser
    universal-ctags
    #fourmolu #too old
    #gnucash
    kubectl
    awscli2
    postgresql
    k9s
    pandoc
    jira-cli-go
    terraform
    kind
    helmfile
    kubernetes-helm
    ngrok
    lorri
    carapace
    actionlint
    calcurse
    newsboat
    #pipe-viewer
    xbanish
    flameshot
    picom
    #fish # managed by programs.fish below
    inputs.nixvim.packages."x86_64-linux".default
    hledger
    darkhttpd
    libwebp
    nodejs_24
    kmonad
    zathura

    # Hyprland / Wayland (For the time being managed by distribution)
    #hyprland
    #waybar
    #kitty
    #wofi
    #hyprpaper
    #hyprlock
    #hypridle
    hyprshot
    #wlsunset
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
    PATH = "/home/igor/.local/bin:/home/igor/bin:/home/igor/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin";
  };

  services.mpris-proxy.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      f = "fg";
      eza = "eza --long --header --git --reverse --sort=size --icons=always";
      tree = "eza --long --header --git --reverse --sort=size --tree --icons=always";
      y = "yazi";
      n = "nvim";
      t = "tmux";
      lg = "lazygit";
      ta = "tmux a";
      nw = "newsboat";
      pv = "pipe-viewer -7";
      pva = "pipe-viewer -7 --no-video";
      download-sections = ''yt-dlp --force-keyframes-at-cuts --recode-video mp4 -f 232+234 --download-sections "$1" "$2"'';
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
