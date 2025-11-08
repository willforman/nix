{ config, pkgs, lib, ... }:

let
  zshSrc = lib.cleanSource ../zsh;
in {
  programs.zsh = {
    enable = true;
 
    shellAliases = {
      c = "clear";
      g = "lazygit";
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
      extended = true;
    };

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    plugins = [
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

    initContent = let
      powerlevelEarlyInit = lib.mkBefore ''
        eval "$(${pkgs.direnv}/bin/direnv export zsh)"
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      zshConfig = ''
        # Autosuggestions
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=80
        ZSH_AUTOSUGGEST_STRATEGY=(history)

        cds() {
          if [[ -n $1 ]]; then
            local dirs=($(fd --type d --maxdepth 1 ".*$1.*" . 2> /dev/null))

            if [[ "''${#dirs[@]}" -eq 1 ]]; then
              cd "''${dirs[1]}"
            else
              local dir=$(echo $dirs | tr " " "\n" | fzf)
              if [[ -n $dir ]]; then
                cd "$dir"
              fi
            fi
          else
            local dir=$(fd --type d --maxdepth 1 ".*$1.*" . 2> /dev/null | fzf)
            if [[ -n $dir ]]; then
              cd "$dir"
            fi
          fi
        }
      '';
    in
    lib.mkMerge [ powerlevelEarlyInit zshConfig ];
  };

  xdg.configFile."fsh/catppuccin-mocha.ini".source = ./catppuccin-mocha.ini;

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;
    keyScheme = "vim";
  };
}
