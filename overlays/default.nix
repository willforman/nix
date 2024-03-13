{ inputs, ... }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  modifications = final: prev: {
    gnupg_2_4_5 = prev.gnupg.overrideAttrs (_: rec {
      pname = "gnupg";
      version = "2.4.5";
      src = prev.fetchurl {
        url = "mirror://gnupg/gnupg/${pname}-${version}.tar.bz2";
        hash = "sha256-9o99ddBssWNcM2002ESvl0NsP2TqFLy3yGl4L5b0Qnc=";
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
