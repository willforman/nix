{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

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
        ]
      ))
    ];
  };

  home.file."./.config/nvim/".source = ./config;
}
