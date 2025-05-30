{
  description = "My nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    darwin, 
    agenix,
    mac-app-util,
    ... 
    } @ inputs: let
      inherit (self) outputs;

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {

      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays { inherit inputs; };
   
    nixosConfigurations = 
      let mkHost = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./os/lib/common.nix
          ./os/nixos/common.nix
          ./os/nixos/${hostname}
        ];
      };
      in {
        dev = mkHost "dev";
        remote-dev = mkHost "remote-dev";
        desktop = mkHost "desktop";
      };

    homeConfigurations = 
      let mkHost = { system, hostname, username, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/lib/common.nix
            ./home-manager/${hostname}
            {
              home = { inherit username homeDirectory; };
            }
            agenix.homeManagerModules.default
            mac-app-util.homeManagerModules.default
          ];
        };
      in {
        dev = mkHost { 
          system = "x86_64-linux";
          hostname = "dev";
          username = "will";
          homeDirectory = "/home/will";
        };
        remote-dev = mkHost { 
          system = "aarch64-linux";
          hostname = "remote-dev";
          username = "will";
          homeDirectory = "/home/will";
        };
        mbp = mkHost { 
          system = "aarch64-darwin";
          hostname = "mbp";
          username = "will";
          homeDirectory = "/Users/will";
        };
        desktop = mkHost { 
          system = "x86_64-linux";
          hostname = "desktop";
          username = "will";
          homeDirectory = "/home/will";
        };
        work = mkHost { 
          system = "aarch64-darwin";
          hostname = "work";
          username = "wforman";
          homeDirectory = "/Users/wforman";
        };
      };

    darwinConfigurations = 
      let mkHost = hostname: darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs outputs; };
        modules = [
          mac-app-util.darwinModules.default
          ./os/lib/common.nix
          ./os/darwin/common.nix
          ./os/darwin/${hostname}
        ];
      };
      in {
        mbp = mkHost "mbp";
        work = mkHost "work";
      };
  };
}
