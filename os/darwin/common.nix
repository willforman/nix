{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../lib/graphical_apps.nix
  ];

  system.stateVersion = 4;
  services.nix-daemon.enable = true;

  users.users = {
    will = {
      shell = pkgs.zsh;
    };
  };
  
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    casks = [
      "ticktick"
      "orion"
      "betterdisplay"
      "spotify"
      "bitwarden"
      "obsidian"
      "anki"
      "numi"
      "firefox"
    ];
  };

  fonts.fontDir.enable = true;
}
