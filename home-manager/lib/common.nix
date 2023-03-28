# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    ./zsh
    ./nvim
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
      outputs.overlays.unstable
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "22.11";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    username = "will";
    homeDirectory = "/home/will";
  };

  programs.git = {
    enable = true;
    userName = "willforman";
    userEmail = "wf8581@gmail.com";

    extraConfig = {
      pull.ff = true;
    };
  };

  home.packages = with pkgs; [
    lazygit
    difftastic
    manix
    tealdeer
    btop
    zip
    unzip
  ];

  programs.tmux = {
    enable = true;

    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    aggressiveResize = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
}
