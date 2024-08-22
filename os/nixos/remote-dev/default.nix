{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../lib/non_work.nix
  ];

  networking.hostName = "remote-dev-wf";
}
