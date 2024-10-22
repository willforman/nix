{ config, pkgs, ...}:
{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "willforman";
    userEmail = "wf8581@gmail.com";

    extraConfig = {
      pull.ff = true;
      init.defaultBranch = "main";
    };
  };

  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {
      anthropic-api-key = {
        file = ../../secrets/anthropic-api-key.age;
      };
    };
  };

  home.sessionVariables = {
    ANTHROPIC_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.anthropic-api-key.path})";
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "willforman";
        email = "wf@willforman.com";
      };
    };
  };
}
