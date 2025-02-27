{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
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

    optimise.automatic = true;

    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
}
