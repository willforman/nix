{ inputs, outputs, lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.tailscale.enable = true;
}
