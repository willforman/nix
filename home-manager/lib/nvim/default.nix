{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;

    extraPackages = with pkgs; [
      ripgrep
      gcc
      nil
      sumneko-lua-language-server
    ];

    plugins = with pkgs.unstable.vimPlugins; [
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
        ]
      ))
    ];
  };

  home.file."./.config/nvim/".source = ./config;
}
