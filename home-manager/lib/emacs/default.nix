{ config, pkgs, lib, ... }:

{
  programs.doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom.d;
    # emacsPackage = pkgs.emacsPgtk;
  };
}
