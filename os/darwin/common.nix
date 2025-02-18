{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../lib/graphical_apps.nix
  ];

  system.stateVersion = 4;

  users.users = {
    will = {
      shell = pkgs.zsh;
    };
  };
  
  # services.yabai = {
  #   enable = true;
  #
  #   config = {
  #     layout = "bsp";
  #     top_padding = 5;
  #     bottom_padding = 5;
  #     left_padding = 5;
  #     right_padding = 5;
  #     window_gap = 5;
  #
  #     mouse_follows_focus = "off";
  #     focus_follows_mouse = "on";
  #     window_placement = "second_child";
  #     window_opacity = "off";
  #     window_opacity_duration = "0.0";
  #     window_shadow = "float";
  #     window_border = "off";
  #     window_border_placement = "inset";
  #     window_border_width = "4";
  #     window_border_radius = "-1.0";
  #     active_window_border_topmost = "off";
  #     active_window_border_color = "0xff775759";
  #     normal_window_border_color = "0xff505050";
  #     insert_window_border_color = "0xffd75f5f";
  #     active_window_opacity = "1.0";
  #     normal_window_opacity = "1.0";
  #     split_ratio = "0.50";
  #     auto_balance = "off";
  #     mouse_modifier = "ctrl";
  #     mouse_action1 = "move";
  #     mouse_action2 = "resize";
  #     window_topmost = "off";
  #   };
  # };

  # services.skhd = {
  #   enable = true;
  #
  #   skhdConfig = ''
  #   # move to other window
  #   alt - h: yabai -m window --focus west
  #   alt - j: yabai -m window --focus south
  #   alt - k: yabai -m window --focus north
  #   alt - l: yabai -m window --focus east
  #
  #   # swap windows
  #   alt - i : yabai -m window --swap west
  #   alt - o : yabai -m window --swap east
  #   cmd - return : alacritty msg create-window || alacritty
  #   cmd - b: open -a Firefox
  #   '';
  # };

  launchd.user.agents.UserKeyMapping.serviceConfig = {
    ProgramArguments = [
      "/usr/bin/hidutil"
      "property"
      # "--match"
      # "{&quot;ProductID&quot;:0x0,&quot;VendorID&quot;:0x0,&quot;Product&quot;:&quot;Apple Internal Keyboard / Trackpad&quot;}"
      "--set"
      (
        let
          # https://developer.apple.com/library/archive/technotes/tn2450/_index.html
          capsLock = "0x700000039";
          deleteOrBackspace = "0x70000002A";
        in
        "{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":${capsLock},\"HIDKeyboardModifierMappingDst\":${deleteOrBackspace}}]}"
      )
    ];
    RunAtLoad = true;
  };
}
