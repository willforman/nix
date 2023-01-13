{ inputs, outputs, lib, config, pkgs, ... }: {
  users.users = {
    will = {
      shell = pkgs.zsh;
    };
  };

  system.stateVersion = 4;
}
