{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    font.size = 16;
  };
}
