{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./lock_screen.nix
  ];

  home.packages = with pkgs; [
    firefox-wayland
    obsidian
    pcmanfm
    thunderbird
    anki-bin
    zathura
  ];

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
