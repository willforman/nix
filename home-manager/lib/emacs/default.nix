{ config, pkgs, ... }:

let
  inherit (pkgs) stdenv;
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.file."./.emacs.d".source = (if stdenv.isDarwin 
    then
      ./config
    else
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/lib/emacs/config"
  );
}
