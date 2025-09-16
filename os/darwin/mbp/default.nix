{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    ./network.nix
    ../../lib/non_work.nix
  ];

  nix.enable = false;

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    casks = [
      "ticktick"
      "betterdisplay"
      "keymapp"
    ];
  };
}
