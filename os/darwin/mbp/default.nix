{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ./network.nix
    ../../lib/graphical_apps.nix
  ];
  services.yabai = {
    enable = true;

    config = {
      layout = "bsp";
      top_padding = 5;
      bottom_padding = 5;
      left_padding = 5;
      right_padding = 5;
      window_gap = 5;

      mouse_follows_focus = "off";
      focus_follows_mouse = "on";
      window_placement = "second_child";
      window_opacity = "off";
      window_opacity_duration = "0.0";
      window_shadow = "float";
      window_border = "off";
      window_border_placement = "inset";
      window_border_width = "4";
      window_border_radius = "-1.0";
      active_window_border_topmost = "off";
      active_window_border_color = "0xff775759";
      normal_window_border_color = "0xff505050";
      insert_window_border_color = "0xffd75f5f";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      auto_balance = "off";
      mouse_modifier = "ctrl";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      window_topmost = "off";
    };
  };
}
