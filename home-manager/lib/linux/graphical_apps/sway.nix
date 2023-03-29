{ config, pkgs, lib, ... }:

{
  imports = [
    ./lock_screen.nix
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
        DP-2 = {
          scale = "1";
          mode = "2560x1440@74.924Hz";
          adaptive_sync = "on";
          bg = "~/.config/sway/wallpapers/wallpaper.jpeg fit";
        };
      };
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export KITTY_ENABLE_WAYLAND=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  xdg.configFile."sway/wallpapers".source = ./wallpapers;

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
    waybar
    wofi
    mako
    wl-clipboard
  ];
}
