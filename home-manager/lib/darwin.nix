{ pkgs, ... }:
{
  imports = [
    ./aerospace
  ];

  home.packages = with pkgs; [
    numi
  ];
}
