{ inputs, outputs, lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    spotify
  ];

  # age = {
  #   identityPaths = [ "/home/will/.ssh/id_ed25519" ];
  # };
}
