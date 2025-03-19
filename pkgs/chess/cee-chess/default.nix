{
  stdenv,
  fetchFromGitHub,
}:
  stdenv.mkDerivation {
    pname = "CeeChess";
    version = "1.4";

    src = fetchFromGitHub {
      owner = "bctboi23";
      repo = "CeeChess";
      rev = "3d53576ae009418eea2da61b54c963d670fb83f1";
      hash = "sha256-twPHChinKFew4Ugsm9oDo7d73P1RyFknPyINvll1rk4=";
    };

    buildPhase = ''
      make
    '';

    installPhase = ''
      mkdir -p $out/bin
      mv bin/CeeChess-v1.4-linux $out/bin
    '';
  }
