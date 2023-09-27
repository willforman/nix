{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../lib/non_work.nix
  ];

  networking.hostName = "dev-wf";

  time.timeZone = "America/New_York";

  # Keep laptop running when lid is shut
  services.logind.lidSwitchExternalPower = "ignore";

  boot.kernelParams = [ 
    "consoleblank=300" # Turn off screen in TTY
  ];
}
