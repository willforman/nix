{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ./network.nix
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  
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
}
