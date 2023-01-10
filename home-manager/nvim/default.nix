{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;

    extraPackages = with pkgs; [
      gcc
      nil
      sumneko-lua-language-server
    ];
  };

  home.file."./.config/nvim/".source = ./config;
}
