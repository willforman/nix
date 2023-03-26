{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    obsidian
    pcmanfm
    # Sway
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
        command = "${pkgs.wayland}/bin/swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        timeout = 240;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
