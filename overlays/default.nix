{ inputs, ... }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  additions = _final: prev: {
    my-aerospace = inputs.nixpkgs-aerospace.legacyPackages.${prev.system}.aerospace;
  };

  modifications = final: prev: {
    my-aerospace = prev.my-aerospace.overrideAttrs (_: rec {
      pname = "aerospace";
      version = "0.15.2-Beta";
      src = prev.fetchzip {
        url = "https://github.com/nikitabobko/AeroSpace/releases/download/v${version}/AeroSpace-v${version}.zip";
        hash = "sha256-jOSUtVSiy/S4nsgvfZZqZjxsppqNi90edn8rcTa+pFQ=";
      };
    });
  };
}
