{ inputs, outputs, lib, config, pkgs, ... }:
{
  nix.settings = {
    eval-cores = 0;
  };

  # age = {
  #   identityPaths = [ "/home/will/.ssh/id_ed25519" ];
  # };
}
