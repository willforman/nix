{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../lib/graphical_apps
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.enableAllFirmware = true;
 
  security.polkit.enable = true;

  boot.kernelPackages = pkgs.unstable.linuxPackages_6_1;

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  networking = {
    hostName = "desktop-wf";
  };

  time.timeZone = "America/New_York";
}
