{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ../lib/graphical_apps.nix
  ];

  home = {
    sessionPath = [
      # for darwin-rebuild
      "${config.home.homeDirectory}/code/nix/build-darwin-result/sw/bin/"
      "/run/current-system/sw/bin" 
      "/nix/var/nix/profiles/default/bin"
      "${config.home.homeDirectory}/.nix-profile/bin"
    ];
  };
}
