{
  description = "Dawn's NixOS configuration";

  inputs = {
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ colmena, home-manager, lix, nixpkgs, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    colmena-config = {
      meta = {
        nixpkgs = pkgs;
        specialArgs = { inherit inputs system; };
      };

      defaults = {
        imports = [ home-manager.nixosModules.home-manager ./hive/common.nix ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      };

      moonrise = {
        imports = [ ./hive/moonrise.nix ];
        deployment = {
          allowLocalDeployment = true;
          targetHost = null;
        };
        home-manager.users.dawn.imports = [ ./home/dawn.nix ./home/moonrise.nix ];
      };

      # sunset = {
      #   imports = [ ./hive/sunset.nix  ];
      #   deployment = {
      #     allowLocalDeployment = false;
      #     targetHost = "159.65.34.173";
      #   };
      #   home-manager.users.dawn.imports = [ ./home/dawn.nix ./home/sunset.nix ];
      # };
    };

    colmena-hive = colmena.lib.makeHive colmena-config;
  in {
    colmena = colmena-config;
    nixosConfigurations = {
      inherit (colmena-hive.nodes) moonrise sunset;
    };
  };
}
