{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    swaylock
  ];

  programs.swaylock.settings = {
    color = "000000";
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
