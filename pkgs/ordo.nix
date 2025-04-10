{
  stdenv,
  fetchFromGitHub,
  pkgs,
  lib,
}: 
stdenv.mkDerivation {
  pname = "Ordo";
  version = "1.2.6";

  buildInputs = with pkgs; [
    gcc
  ];

  src = fetchFromGitHub {
    owner = "gsobala";
    repo = "Ordo";
    rev = "5d18731fbed0a26b7772d6793d07787ebf6ad164";
    hash = "sha256-VbpNSWsv9n8q397AQRxaSBWZgJcFHzdWO2gBiOHrHBI=";
  };

  buildPhase = ''
    make ordo
  '';

  installPhase = ''
    mkdir -p $out/bin
    ls
    mv ordo $out/bin
  '';
}
