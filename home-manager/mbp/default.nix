{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ../lib/darwin.nix
    ../lib/graphical_apps.nix
    ../lib/non_work.nix
    ../lib/non_work_graphical.nix
  ];

  home = {
    sessionPath = [
      # for darwin-rebuild
      "${config.home.homeDirectory}/code/nix/build-darwin-result/sw/bin/"
      "/run/current-system/sw/bin" 
      "/nix/var/nix/profiles/default/bin"
      "${config.home.homeDirectory}/.nix-profile/bin"
    ];
    packages = with pkgs; [
      wireguard-tools
    ];
  };

  services = {
    syncthing.enable = true;
  };
}
