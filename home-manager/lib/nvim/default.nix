{ config, pkgs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    defaultEditor = true;

    # We manage the entire nvim config via the out-of-store symlink below, so
    # don't let the module write its own ~/.config/nvim/init.lua (it would
    # collide with that symlink). sideloadInitLua sets the generated init.lua's
    # enable = false for us.
    sideloadInitLua = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      nixd
      lua-language-server
      fennel-ls
      sqlite
      bash-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          lua
          c
          cpp
          css
          elixir
          go
          html
          java
          lua
          nix
          python
          rust
          javascript
          typescript
          tsx
          bash
          heex
          fennel
          just
        ]
      ))
    ];
  };

  xdg.configFile."nvim".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/nvim/config";

  home.sessionVariables = {
    MANPAGER = "nvim -c 'Man!' -o -";
    LIBSQLITE = if pkgs.stdenv.isLinux then
      "${pkgs.sqlite.out}/lib/libsqlite3.so"
    else
      "${pkgs.sqlite.out}/lib/libsqlite3.dylib";
  };
}
