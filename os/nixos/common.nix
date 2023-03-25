{ inputs, outputs, lib, config, pkgs, ... }: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  users.users = {
    will = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEd+kmG9ScsNZZtqNRnhsBIBBSM5sv/ma8cuHTjGU6UQ wf8581@gmail.com"
      ];
      extraGroups = [ "wheel" "docker" "sound" ];
      shell = pkgs.zsh;
    };
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "22.11";
}
