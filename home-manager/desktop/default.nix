{ config, pkgs, lib, ... }:
{
  imports = [
    ../lib/graphical_apps.nix
  ];
  
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show run";
      bars = [];
      output = {
        e-DP-1 = {
          scale = "1";
        };
      };
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        modules-left = [ "sway/workspaces" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "temperature" "disk" "cpu" "memory" "clock" ];
      };
    };
  };

  home.packages = with pkgs; [
    dmenu
    waybar
    wofi
    mako
  ];

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    KITTY_ENABLE_WAYLAND = 1;
  };
}
