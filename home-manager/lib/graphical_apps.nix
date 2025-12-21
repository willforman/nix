{ config, pkgs, lib, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
  };

  xdg.configFile."ghostty/config".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/ghostty-config";

  home.packages = with pkgs; [
    obsidian
    bitwarden-desktop
    anki-bin
    spotify
  ];

  programs.firefox = {
    enable = true;
  };
}
