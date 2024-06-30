{ config, lib, pkgs, ... }:

{


  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Brazil/East";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
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

  users.users.igor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    password = "nixos";
  };

  services.openssh.settings.PermitRootLogin = lib.mkOverride 999 "yes";
  services.getty.autologinUser = lib.mkOverride 999 "root";

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
