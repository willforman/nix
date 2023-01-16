{
  description = "My nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darwin, agenix, ... }@inputs: 
    let
      inherit (self) outputs;
    in
    {

    overlays = import ./overlays { inherit inputs; };
   
    nixosConfigurations = 
      let mkHost = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./os/common.nix
          ./os/nixos/common.nix
          ./os/nixos/${hostname}

          agenix.nixosModule
        ];
      };
      in {
        dev = mkHost "dev";
      };

    homeConfigurations = 
      let mkHost = system: hostname: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home-manager/common
          ./home-manager/${hostname}
        ];
      };
      in {
        dev = mkHost "x86_64-linux" "dev";
        mbp = mkHost "aarch64-darwin" "dev";
      };

    darwinConfigurations = 
      let mkHost = hostname: darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./os/darwin/common.nix
          ./os/darwin/${hostname}

          agenix.nixosModule
        ];
      };
      in {
        mbp = mkHost "mbp";
      };
  };
}
