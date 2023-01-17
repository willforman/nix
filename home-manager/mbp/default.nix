{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ../lib/graphical_apps.nix
  ];

  home.packages = with pkgs; [
    wireguard-tools
  ];
}
