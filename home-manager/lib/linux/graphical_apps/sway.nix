{ config, pkgs, lib, ... }:

{
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
      input = {
        "12951:6505:ZSA_Technology_Labs_Moonlander_Mark_I" = {
          repeat_delay = "300";
          repeat_rate = "30";
        };
      };
    };
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
      export KITTY_ENABLE_WAYLAND=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  xdg.configFile."sway/wallpapers".source = ./wallpapers;

  home.packages = with pkgs; [
    wofi
    mako
    wl-clipboard
  ];
}
