{ inputs, outputs, lib, config, pkgs, ... }: 
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    ./zsh
    ./nvim
    # ./emacs
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.modifications
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "nodejs-16.20.0"
        "nodejs-16.20.2"
      ];
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "22.11";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    lazygit
    difftastic
    manix
    tealdeer
    btop
    zip
    unzip
    ripgrep
    nnn
    tree
    fd
    fzf
    bat
    sqlite
  ];

  programs.tmux = {
    enable = true;

    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    aggressiveResize = true;
    mouse = true;
    clock24 = false;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };

  programs.gpg = {
    enable = true;
    package = pkgs.gnupg_2_4_5;
  };
}
