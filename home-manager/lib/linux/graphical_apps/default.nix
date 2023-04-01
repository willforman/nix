{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./waybar
    ./lock_screen.nix
  ];

  home.packages = with pkgs; [
    firefox-wayland
    obsidian
    pcmanfm
    thunderbird
    anki-bin
    zathura
    feh
    font-manager
  ];

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
