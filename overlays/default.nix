{ inputs, ... }:

{
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    sha256 = "0izf3vkhww7sns1j7d7bd0069h8kjlkmykdp1941cvgfygphxj8d";
  });
}
