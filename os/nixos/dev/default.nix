{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "dev-wf";
  };

  time.timeZone = "America/New_York";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Keep laptop running when lid is shut
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';
}
