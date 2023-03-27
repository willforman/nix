{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 16;
    };

    extraConfig = ''
    # github colors for Kitty
    background #24292e
    foreground #d1d5da
    selection_background #284566
    selection_foreground #d1d5da
    url_color #d1d5da
    cursor #c8e1ff
    cursor_text_color background

    # Tabs
    active_tab_background #2188ff
    active_tab_foreground #1f2428
    inactive_tab_background #666666
    inactive_tab_foreground #1f2428

    # Windows Border
    active_border_color #444c56
    inactive_border_color #444c56

    # normal
    color0 #586069
    color1 #ea4a5a
    color2 #34d058
    color3 #ffea7f
    color4 #2188ff
    color5 #b392f0
    color6 #39c5cf
    color7 #d1d5da

    # bright
    color8 #959da5
    color9 #f97583
    color10 #85e89d
    color11 #ffea7f
    color12 #79b8ff
    color13 #b392f0
    color14 #56d4dd
    color15 #fafbfc

    # extended colors
    color16 #ffea7f
    color17 #f97583
    '';
  };

  home.packages = with pkgs; [
    vscode
    obsidian
  ];
}
