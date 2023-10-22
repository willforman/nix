{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ../../lib/non_work.nix
  ];

  networking.hostName = "dev-wf";

  # Keep laptop running when lid is shut
  services.logind.lidSwitchExternalPower = "ignore";

  boot.kernelParams = [ 
    "consoleblank=300" # Turn off screen in TTY
  ];
}
