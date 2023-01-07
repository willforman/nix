{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    unstable.neovim
  ];
}
