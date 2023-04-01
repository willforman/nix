{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ ];
        modules-right = [ "cpu" "memory" "wireplumber" "clock" ];
        memory = {
          format = "{used:0.1f}G ";
        };
        cpu = {
          format = "{load:0.1f}% ";
        };
        clock = {
          format = "<b>{:%a %b %d %I:%M %p}</b>";
        };
        wireplumber = {
          format = "{volume}% ";
          format-muted = "";
          format-icons = [ "" "" "" ];
        };
      };
    };
    style = ./style.css;
  };
}
