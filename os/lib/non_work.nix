{ inputs, outputs, lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;

  age = {
    identityPaths = [ "/home/will/.ssh/id_ed25519" ];
  };
}
