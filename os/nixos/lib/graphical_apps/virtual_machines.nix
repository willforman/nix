{ config, pkgs, lib, ... }:

let 
  enable = false;
in
{
  virtualisation.libvirtd.enable = enable;

  programs.dconf.enable = enable;

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
