{
  description = "My nix config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    darwin, 
    agenix,
    nix-doom-emacs,
    ... 
    }@inputs: 
    let
      inherit (self) outputs;
    in
    {

    overlays = import ./overlays { inherit inputs; };
   
    nixosConfigurations = 
      let mkHost = hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./os/lib/common.nix
          ./os/nixos/common.nix
          ./os/nixos/${hostname}

          agenix.nixosModule
        ];
      };
      in {
        dev = mkHost "dev";
        desktop = mkHost "desktop";
      };

    homeConfigurations = 
      let mkHost = system: hostname: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home-manager/lib/common.nix
          ./home-manager/${hostname}
          nix-doom-emacs.hmModule
        ];
      };
      in {
        dev = mkHost "x86_64-linux" "dev";
        mbp = mkHost "aarch64-darwin" "mbp";
        desktop = mkHost "x86_64-linux" "desktop";
      };

    darwinConfigurations = 
      let mkHost = hostname: darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./os/lib/common.nix
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
