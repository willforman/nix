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
        e-DP-1 = {
          scale = "1";
        };
      };
    };
    # extraSessionCommands = ''
    #   export WLR_NO_HARDWARE_CURSORS = 1
    #   export KITTY_ENABLE_WAYLAND = 1
    #   export MOZ_ENABLE_WAYLAND = 1
    # '';
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
    waybar
    wofi
    mako
    wl-clipboard
  ];

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    KITTY_ENABLE_WAYLAND = 1;
    MOZ_ENABLE_WAYLAND = 1;
  };
}
