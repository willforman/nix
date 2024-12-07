{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    checkConfig = false;
    config = {
      modifier = "Mod1";
      terminal = "alacritty";
      menu = "wofi --show run";
      bars = [];
      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/.config/sway/wallpapers/wallpaper.jpeg fit";
        };
        DP-2 = {
          scale = "1.15";
          mode = "2560x1440@74.924Hz";
          adaptive_sync = "on";
        };
      };
      gaps = {
        inner = 10;
        outer = 5;
      };
      input = {
        "*" = {
          repeat_delay = "300";
          repeat_rate = "30";
          xkb_layout = "us";
          xkb_variant = "colemak";
        };
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+q" = "kill";
        "${modifier}+Shift+q" = "exec systemctl suspend";
        "${modifier}+b" = "exec firefox";
        "${modifier}+n" = "focus left";
        "${modifier}+e" = "focus down";
        "${modifier}+i" = "focus up";
        "${modifier}+o" = "focus right";
        "${modifier}+shift+n" = "move left";
        "${modifier}+shift+e" = "move down";
        "${modifier}+shift+i" = "move up";
        "${modifier}+shift+o" = "move right";
        "${modifier}+shift+k" = "exit";
        "${modifier}+slash" = "layout toggle split";
        "${modifier}+comma" = "layout stacking";
        "${modifier}+period" = "layout tabbed";
      };
    };
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export MOZ_ENABLE_WAYLAND=1
      export NIXOS_OZONE_WL=1
    '';
  };

  xdg.configFile."sway/wallpapers".source = ./wallpapers;

  home.packages = with pkgs; [
    wofi
    wl-clipboard
  ];

  services.mako = {
    enable = true;

    defaultTimeout = 8000;
  };
}
