{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../lib/graphical_apps
  ];

  hardware.enableAllFirmware = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "desktop-wf";
  };

  time.timeZone = "America/New_York";
}
