{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ../lib/graphical_apps.nix
  ];

  home = {
    sessionPath = [
      # for darwin-rebuild
      "${config.home.homeDirectory}/code/nix/build-darwin-result/sw/bin/"
    ];
    packages = with pkgs; [
      wireguard-tools
    ];
  };
}
