{
  description = "Happytech's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system_settings = {
        system = "x86_64-linux";
        profile = "personal-dualboot";
      };

      user_settings = {
        username = "happytech";
        hostname = "happyMachine";
        name = "HappyTech";
        email = "happytech.web@gmail.com";
      };

      global_utils = {
        root_path = ./.;
      };
    in {
      nixosConfigurations.${user_settings.hostname} = nixpkgs.lib.nixosSystem {
        system = system_settings.system;
        modules = [
          (./profiles + "/${system_settings.profile}/configuration.nix")
        ];
        specialArgs = {
          inherit system_settings;
          inherit user_settings;
          inherit global_utils;
        };
      };
      homeConfigurations = {
        ${user_settings.username} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system_settings.system};
          modules = [
          (./profiles + "/${system_settings.profile}/home.nix")
          ];
          extraSpecialArgs = {
            inherit user_settings;
            inherit global_utils;
          };
        };
      };
    };
}
