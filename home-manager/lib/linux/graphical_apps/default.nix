{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./waybar
    ./lock_screen.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    firefox
    obsidian
    pcmanfm
    thunderbird
    zathura
    feh
    font-manager
  ];

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
