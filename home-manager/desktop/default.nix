{ config, pkgs, lib, ... }:
{
  imports = [
    ../lib/graphical_apps.nix
    ../lib/linux/graphical_apps
  ];

  services.blueman-applet.enable = true;
}
