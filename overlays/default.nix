{ inputs, ... }:

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
  };
}
