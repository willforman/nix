{ config, pkgs, ... }:

let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    defaultEditor = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      nil
      lua-language-server
      nodePackages.bash-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          lua
          c
          css
          elixir
          go
          html
          java
          lua
          nix
          python
          rust
          typescript
          tsx
          bash
          heex
        ]
      ))
    ];
  };

  home.file."./.config/nvim".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/nvim/config";
}
