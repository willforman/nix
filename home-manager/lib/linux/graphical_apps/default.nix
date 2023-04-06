{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./waybar
    ./lock_screen.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    firefox-wayland
    obsidian
    pcmanfm
    thunderbird
    anki-bin
    zathura
    feh
    font-manager
  ];

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=15";
        dpi-aware = "yes";
      };
      colors = {
        background = "24292e";
        foreground = "d1d5da";
        regular0 = "586069";
        regular1 = "ea4a5a";
        regular2 = "34d058";
        regular3 = "ffea7f";
        regular4 = "2188ff";
        regular5 = "b392f0";
        regular6 = "39c5cf";
        regular7 = "d1d5da";
        bright0 = "959da5";
        bright1 = "f97583";
        bright2 = "85e89d";
        bright3 = "ffea7f";
        bright4 = "79b8ff";
        bright5 = "b392f0";
        bright6 = "56d4dd";
        bright7 = "fafbfc";
      };
    };
  };
}
