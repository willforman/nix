{ config, pkgs, ... }:

let
  my-emacs = (pkgs.emacsPackagesFor pkgs.emacs29-pgtk).emacsWithPackages (
    epkgs: with epkgs; [
      vterm
      (treesit-grammars.with-grammars (p: [
        p.tree-sitter-rust
        p.tree-sitter-elisp
        p.tree-sitter-nix
      ]))
    ]
  );
  inherit (pkgs) stdenv;
in
{
  programs.emacs = {
    enable = true;
    package = my-emacs;
  };

  home.file."./.emacs.d".source = (if stdenv.isDarwin 
    then
      ./config
    else
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/lib/emacs/config"
  );
}
