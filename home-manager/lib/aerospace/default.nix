{ pkgs, config, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.packages = with pkgs; [
    aerospace
  ];

  xdg.configFile."aerospace/aerospace.toml".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/aerospace/aerospace.toml";
}
