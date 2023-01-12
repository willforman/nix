{ config, pkgs, lib, ... }:

# Copied parts from https://github.com/Scoder12/dotfiles/blob/99a1bc0dbe1b6732e3238e7b126890fc325f4953/home-manager/modules/zsh/zsh.nix
let
  zshSrc = lib.cleanSource ../zsh;
in {
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

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "p10k-config";
        src = zshSrc;
        file = "p10k.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      # Autosuggestions
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
      ZSH_AUTOSUGGEST_STRATEGY=(history)
    '';
  };

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;
    keyScheme = "vim";
  };
}
