{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
 
    shellAliases = {
      c = "clear";
      g = "git";
      y = "yarn";
      e = "$EDITOR";
      ls = "ls --color=auto";
    };
    
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      save = 1000000;
      size = 1000000;
      share = true;
    };

    # Plugins
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
  };

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;
    keyScheme = "vim";
  };
}
