{ config, lib, pkgs, modulesPath, self, ... }:

{

  imports = [
    "${modulesPath}/profiles/base.nix"
    "${modulesPath}/profiles/all-hardware.nix"
    "${modulesPath}/installer/cd-dvd/iso-image.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Brazil/East";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager = {
    sddm.enable = true;
  };

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  services.xserver.xkb.layout = "br";
  services.xserver.xkb.options = "eurosign:e,caps:escape";


  hardware.pulseaudio.enable = true;

  services.libinput.enable = true;

  services.sshd.enable = true;

  users.users.root.password = "nixos";

  programs.zsh.enable = true;

  users.users.igor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "video" "input" "audio" ];
    packages = with pkgs; [
      tree
    ];
    password = "nixos";
  };

  services.openssh.settings.PermitRootLogin = lib.mkOverride 999 "yes";
  services.getty.autologinUser = lib.mkOverride 999 "root";

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tmux
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
