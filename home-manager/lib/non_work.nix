{ config, pkgs, ...}:
{
  home.packages = with pkgs; [
    ordo
    cutechess
  ];

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.git = {
    settings = {
      user = {
        name = "willforman";
        email = "wf8581@gmail.com";
      };
    };
  };

  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {};
  };

  # programs.jujutsu = {
  #   enable = true;
  #   settings = {
  #     user = {
  #       name = "willforman";
  #       email = "wf@willforman.com";
  #     };
  #   };
  # };
}
