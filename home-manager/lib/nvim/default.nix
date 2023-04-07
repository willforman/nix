{ config, pkgs, lib, ... }:

let
  inherit (pkgs) stdenv;
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
        ]
      ))
    ];
  };

  home.file."./.config/nvim".source = (if stdenv.isDarwin 
    then
      ./config
    else
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/lib/nvim/config"
  );
}
