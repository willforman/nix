{
  stdenv,
  fetchFromGitHub,
}:
  stdenv.mkDerivation {
    pname = "ShallowBlue";
    version = "2.0.0";

    src = fetchFromGitHub {
      owner = "GunshipPenguin";
      repo = "shallow-blue";
      rev = "a04fbd9861770c897eb566d83b0d2e3b17aa9fc0";
      hash = "sha256-PgAwByWzDe5Blll62aLhiodvcpKKWwoodDiZc+HbD3U=";
    };

    postPatch = ''
      sed -i '1i\#include <string>' src/option.h
    '';

    buildPhase = ''
      make
    '';

    installPhase = ''
      mkdir -p $out/bin
      mv shallowblue $out/bin
    '';
  }
