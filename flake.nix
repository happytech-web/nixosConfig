{
  description = "Happytech's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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
    self, nixpkgs, nixpkgs-unstable, home-manager,
    stylix, noctalia, ...
  }@inputs:
    let
      system_settings = {
        system = "x86_64-linux";
        hostname = "happyMachine";
        profile = "personal-dualboot";
      };

      user_settings = {
        username = "happytech";
        name = "HappyTech";
        email = "happytech.web@gmail.com";
      };

      global_utils = rec {
        root_path = ./.;
        user_path = root_path + /user;
        system_path = root_path + /system;
        home_path = /home + "/" + user_settings.username;
        pkgs-unstable = import nixpkgs-unstable {
          system = system_settings.system;
          config.allowUnfree = true;
        };
        # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system_settings.system};
      };
    in {
      nixosConfigurations.${system_settings.hostname} = nixpkgs.lib.nixosSystem {
        system = system_settings.system;
        modules = [
          (./profiles + "/${system_settings.profile}/configuration.nix")
        ];
        specialArgs = {
          inherit inputs;
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
            inherit inputs;
            inherit user_settings;
            inherit global_utils;
          };
        };
      };
    };
}
