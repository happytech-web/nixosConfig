{
  description = "Happytech's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix ={
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs, nixpkgs-darwin, nixpkgs-unstable, home-manager, ...
  }@inputs:
    let
      base_user_settings = {
        username = "happytech";
        name = "HappyTech";
        email = "happytech.web@gmail.com";
      };

      nixos_hosts = {
        happyMachine = {
          system = "x86_64-linux";
          profile = "personal-dualboot";
          pkgsSource = nixpkgs;
          user_settings = base_user_settings // {
            homeDirectory = "/home/${base_user_settings.username}";
          };
        };
      };

      darwin_hosts = {
        happyMac = {
          system = "aarch64-darwin";
          profile = "personal-macos";
          pkgsSource = nixpkgs-darwin;
          user_settings = base_user_settings // {
            homeDirectory = "/Users/${base_user_settings.username}";
          };
        };
      };

      mkSystemSettings = hostname: host: {
        inherit hostname;
        inherit (host) system profile;
      };

      mkPkgs = pkgsSource: system:
        import pkgsSource {
          inherit system;
          config.allowUnfree = true;
        };

      mkGlobalUtils = { system_settings, user_settings }:
        rec {
          root_path = ./.;
          user_path = root_path + /user;
          system_path = root_path + /system;
          home_path = user_settings.homeDirectory;
          dotfiles_path = home_path + "/.dotfiles";
          pkgs-unstable = import nixpkgs-unstable {
            system = system_settings.system;
            config.allowUnfree = true;
          };
        };

      mkArgs = hostname: host:
        let
          system_settings = mkSystemSettings hostname host;
          user_settings = host.user_settings;
          global_utils = mkGlobalUtils {
            inherit system_settings user_settings;
          };
        in {
          inherit inputs system_settings user_settings global_utils;
        };

      mkHomeConfiguration = hostname: host:
        let
          system_settings = mkSystemSettings hostname host;
        in home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs host.pkgsSource system_settings.system;
          modules = [
            inputs.stylix.homeModules.stylix
            (./profiles + "/${system_settings.profile}/home.nix")
          ];
          extraSpecialArgs = mkArgs hostname host;
        };
    in {
      nixosConfigurations =
        nixpkgs.lib.mapAttrs
          (hostname: host:
            let
              system_settings = mkSystemSettings hostname host;
            in nixpkgs.lib.nixosSystem {
              system = system_settings.system;
              modules = [
                (./profiles + "/${system_settings.profile}/configuration.nix")
              ];
              specialArgs = mkArgs hostname host;
            })
          nixos_hosts;

      darwinConfigurations =
        nixpkgs.lib.mapAttrs
          (hostname: host:
            let
              system_settings = mkSystemSettings hostname host;
              args = mkArgs hostname host;
              user_settings = host.user_settings;
            in inputs."nix-darwin".lib.darwinSystem {
              system = system_settings.system;
              modules = [
                (./profiles + "/${system_settings.profile}/darwin.nix")
                home-manager.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.sharedModules = [ inputs.stylix.homeModules.stylix ];
                  home-manager.extraSpecialArgs = args;
                  home-manager.users.${user_settings.username} =
                    import (./profiles + "/${system_settings.profile}/home.nix");
                }
              ];
              specialArgs = args;
            })
          darwin_hosts;

      homeConfigurations =
        (nixpkgs.lib.mapAttrs'
          (hostname: host:
            nixpkgs.lib.nameValuePair
              "${host.user_settings.username}@${hostname}"
              (mkHomeConfiguration hostname host))
          nixos_hosts)
        //
        (nixpkgs.lib.mapAttrs'
          (hostname: host:
            nixpkgs.lib.nameValuePair
              "${host.user_settings.username}@${hostname}"
              (mkHomeConfiguration hostname host))
          darwin_hosts);
    };
}
