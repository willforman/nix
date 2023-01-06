{ inputs, ... }:

{
  unstable = final: _prev: {
    unstable = inputs.nixpkgs-unstable.legacyPackages.${final.system};
  };
}
