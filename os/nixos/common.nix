{ inputs, outputs, lib, config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;

  users.users = {
    will = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1QyYRF8aah8vn6hLZoFNhK0CZM+39IgyuixzoERyQw wf8581@gmail.com"
      ];
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };

  system.stateVersion = "22.11";
}
