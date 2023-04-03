{ config, pkgs, lib, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    # emacsPackage = pkgs.emacsPgtk;
  };

  services.emacs = {
    enable = true;
    # package = pkgs.emacsPgtk;
  };
}
