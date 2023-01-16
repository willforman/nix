{ lib, config, pkgs, ... }: 

{
  fonts.fonts = with pkgs; [
    jetbrains-mono
  ];
}
