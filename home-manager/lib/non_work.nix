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
    };
  };
}
