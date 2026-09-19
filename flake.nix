{
  description = "Home Manager config (Fedora + flakes)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim.url = "github:igor-primo/nixvim";
    llm-agents.url = "github:numtide/llm-agents.nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, llm-agents, ... }:
    let
      system = "x86_64-linux";
      # system32bit = "i686-linux";
      username = "igor";
    in
    {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};

          modules = [
            ./home.nix
          ];

          extraSpecialArgs = {
            inherit inputs;
          };
        };

      nixosConfigurations.live = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
          home-manager.nixosModules.home-manager
          ({ pkgs, ... }: {
            users.users.${username} = {
              isNormalUser = true;
              password = "live";
              extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
              shell = pkgs.fish;
            };

            programs.fish.enable = true;
            security.sudo.wheelNeedsPassword = false;
            environment.systemPackages = with pkgs; [
              ghostty
              kmonad
              chromium
              networkmanager
            ];

            # install chromium plugins
            environment.etc."chromium/policies/managed/extensions.json".text = builtins.toJSON {
              ExtensionInstallForcelist = [
                "dbepggeogbaibhgnhhndojpepiihcmeb;https://clients2.google.com/service/update2/crx" # Vimium
                "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx" # Bitwarden
              ];
            };

            nixpkgs.config.pulseaudio = true;
            networking.wireless.enable = false;
            networking.networkmanager.enable = true;
            # networking.wireless = {
            #   enable = true;
            #   networks."NOME_DA_REDE".psk = "SENHA_DA_REDE";
            # };

            services.xserver = {
              enable = true;
              desktopManager = {
                xfce.enable = true;
                xterm.enable = false;
              };
              xkb = {
                layout = "br";
                variant = "abnt2";
              };
            };

            console.keyMap = "br-abnt2";

            services.displayManager.defaultSession = "xfce";
            programs.chromium.enable = true;

            # hardware.pulseaudio.enable = true;
            hardware.bluetooth = {
              enable = true;
              powerOnBoot = true;
            };
            services.blueman.enable = true;

            users.groups.input = { };
            services.udev.extraRules = ''
              KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
            '';

            systemd.services = {
              kmonad-notebook = {
                description = "KMonad keyboard remapper";
                wantedBy = [ "multi-user.target" ];
                after = [ "systemd-udev-settle.service" ];
                serviceConfig = {
                  Type = "simple";
                  ExecStart = "${pkgs.kmonad}/bin/kmonad /etc/kmonad/notebook.kbd";
                  Restart = "on-failure";
                  RestartSec = 3;
                };
              };

              kmonad-mechanical = {
                description = "KMonad keyboard remapper mechanical";
                wantedBy = [ "multi-user.target" ];
                after = [ "systemd-udev-settle.service" ];
                serviceConfig = {
                  Type = "simple";
                  ExecStart = "${pkgs.kmonad}/bin/kmonad /etc/kmonad/mechanical.kbd";
                  Restart = "on-failure";
                  RestartSec = 3;
                };
              };
            };

            environment.etc = {
              "kmonad/notebook.kbd".source = ./dotfiles/kmonad-normal.kbd;
              "kmonad/mechanical.kbd".source = ./dotfiles/kmonad.kbd;
            };

            nixpkgs.config.allowUnfree = true;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };

            isoImage.makeEfiBootable = true;
            isoImage.makeUsbBootable = true;
            isoImage.makeBiosBootable = true;

            system.stateVersion = "25.05";
          })
        ];
      };
      packages.${system}.iso =
        self.nixosConfigurations.live.config.system.build.isoImage;
    };
}
