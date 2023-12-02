{ config, pkgs, ... }:

let
  inherit (pkgs) stdenv;
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  home.file."./.emacs.d".source = (if stdenv.isDarwin 
    then
      ./config
    else
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/lib/emacs/config"
  );
}
