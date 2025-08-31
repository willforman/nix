pkgs: {
  ordo = pkgs.callPackage ./ordo.nix { };
  cutechess = pkgs.callPackage ./cutechess.nix { };
}
