{ config, pkgs, lib, ... }:
{
  imports = [
    ../lib/graphical_apps.nix
    ../lib/linux
    ../lib/linux/graphical_apps
    ../lib/non_work.nix
    ../lib/non_work_graphical.nix
  ];

  services = {
    blueman-applet.enable = true;

    syncthing.enable = true;
  };
}
