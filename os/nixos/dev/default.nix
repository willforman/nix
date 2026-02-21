{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./jobs.nix
    ../../lib/non_work.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;

  networking.hostName = "dev-wf";

  # Keep laptop running when lid is shut
  services.logind.lidSwitchExternalPower = "ignore";

  boot.kernelParams = [ 
    "consoleblank=300" # Turn off screen in TTY
  ];
}
