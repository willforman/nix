{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../lib/graphical_apps
  ];

  hardware.enableAllFirmware = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  security.rtkit.enable = true;
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
