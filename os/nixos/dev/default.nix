{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  networking = {
    hostName = "dev-wf";
  };

  time.timeZone = "America/New_York";

  # Keep laptop running when lid is shut
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';
}
