{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./network.nix
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  systemd.services.iwd.serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";

  networking = {
    hostName = "dev-wf";
    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
      };
    };
  };

  time.timeZone = "Americas/Chicago";

  # Keep laptop running when lid is shut
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';
}
