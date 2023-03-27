{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./lock_screen.nix
  ];

  home.packages = with pkgs; [
    obsidian
    pcmanfm
    thunderbird
  ];

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
