{ config, pkgs, lib, ... }:

{
  programs.swaylock.settings = {
    image = "~/.config/sway/wallpapers/wallpaper.jpeg";
    clock = true;
    effect-blur = "7x5";
    indicator-idle-visible = true;
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock";
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
