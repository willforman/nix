{
  description = "My nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, agenix, ... }@inputs: 
    let
      inherit (self) outputs;
    in
    {

    overlays = import ./overlays { inherit inputs; };
   
    nixosConfigurations = 
      let mkHost = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/common.nix
          ./nixos/${hostname}

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
      };
  };
}
