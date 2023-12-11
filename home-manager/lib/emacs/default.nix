{ config, pkgs, ... }:

let
  emacs-package = with pkgs; if stdenv.isDarwin 
    # then darwin-emacs29
    then emacs29-macport
    else emacs29-pgtk;

  my-emacs = (pkgs.emacsPackagesFor emacs-package).emacsWithPackages (
    epkgs: with epkgs; [
      vterm
      (treesit-grammars.with-grammars (p: [
        p.tree-sitter-rust
        p.tree-sitter-elisp
        p.tree-sitter-nix
      ]))
    ]
  );
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.emacs = {
    enable = true;
    package = my-emacs;
  };

  home.file."./.emacs.d".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/code/nix/home-manager/lib/emacs/config";
}
