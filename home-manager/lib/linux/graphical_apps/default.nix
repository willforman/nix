{ config, pkgs, lib, ... }:

{
  imports = [
    ./lock_screen.nix
  ];

  home.packages = with pkgs; [
    obsidian
    pcmanfm
  ];
}
