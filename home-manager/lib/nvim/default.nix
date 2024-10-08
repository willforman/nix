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
      nixd
      lua-language-server
      fennel-ls
      sqlite
      nodePackages.bash-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          # lua
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
          fennel
        ]
      ))
    ];
  };

  home.file."./.config/nvim".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/nvim/config";
  home.file."./.config/fennel/fennelrc".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/nvim/fennelrc.fnl";

  home.sessionVariables = {
    MANPAGER = "nvim -c 'Man!' -o -";
    LIBSQLITE = if pkgs.stdenv.isLinux then
      "${pkgs.sqlite.out}/lib/libsqlite3.so"
    else
      "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
  };
}
