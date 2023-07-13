{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    tailscale
  ];

  age = {
    identityPaths = [ "/home/will/.ssh/id_ed25519" ];
  };

  services.tailscale.enable = true;
  networking = {
    nameservers = [
      "100.100.100.100"
      "1.1.1.1"
    ];

    search = [ "tail8135e.ts.net" ];
  };
}
