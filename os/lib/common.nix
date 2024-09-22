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

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  age = {
    identityPaths = [ "${config.users.users.will.home}/.ssh/id_ed25519" ];
    secrets = {
      "anthropic-api-key" = {
        file = ../../secrets/anthropic-api-key.age;
      };
    };
  };
}
