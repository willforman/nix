{ inputs, ... }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  modifications = final: prev: {
    gnupg_2_4_0 = prev.gnupg.overrideAttrs (_: rec {
      pname = "gnupg";
      version = "2.4.0";
      src = prev.fetchurl {
        url = "mirror://gnupg/gnupg/${pname}-${version}.tar.bz2";
        hash = "sha256-HXkVjdAdmSQx3S4/rLif2slxJ/iXhOosthDGAPsMFIM=";
      };
    });

    darwin-emacs29 = addPatches prev.emacs29-macport [
      ./emacs-darwin/fix-window-role.patch
      ./emacs-darwin/poll.patch
      ./emacs-darwin/round-undecorated-frame.patch
      ./emacs-darwin/system-appearance.patch
    ];
  };
}
