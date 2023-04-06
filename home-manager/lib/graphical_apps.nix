{ config, pkgs, lib, ... }:

{
  
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 16.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };
      colors = {
        primary = {
          background = "0x24292e";     
          foreground = "0xd1d5da";
        };
        normal = {
          black = "0x586069";
          red = "0xea4a5a";
          green = "0x34d058";
          yellow = "0xffea7f";
          blue = "0x2188ff";
          magenta = "0xb392f0";
          cyan = "0x39c5cf";
          white = "0xd1d5da";
        };

        bright = {
          black = "0x959da5";
          red = "0xf97583";
          green = "0x85e89d";
          yellow = "0xffea7f";
          blue = "0x79b8ff";
          magenta = "0xb392f0";
          cyan = "0x56d4dd";
          white = "0xfafbfc";
        };
        indexed_colors = [
          { 
            index = 16;
            color = "0xd18616";
          }
          {
            index = 17;
            color = "0xf97583";
          }
        ];
      };
    };
  };
    
  programs.vscode = {
    enable = true;
  };

  home.packages = with pkgs; [
    obsidian
  ];
}
