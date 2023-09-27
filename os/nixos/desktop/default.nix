{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../lib/graphical_apps
    ../../lib/non_work.nix
  ];

  networking.hostName = "desktop-wf";

  time.timeZone = "America/New_York";

  hardware.enableAllFirmware = true;

  networking.wireless.iwd.enable = true;
}
