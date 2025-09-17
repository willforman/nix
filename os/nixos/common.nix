{ inputs, outputs, lib, config, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };

  users.users = {
    will = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINT6g7uwS7pKQ1XKmfGCuwb2RUgHOYKYWCV7fKrh34X6 wf@willforman.com
" # mbp
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSSsTq5FjE5T6k0XYjulF89EHiYl4XRt9sMuIE7ah0N wf8581@gmail.com" # dev
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4rvLHPVeJWl8WHQimBAAIv8fPykLhUphwbwH+fk/oG wf@willforman.com" # mbp2
      ];
      extraGroups = [ "wheel" "docker" "sound" "libvirtd" ];
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;

  virtualisation.docker = {
    enable = true;
    extraOptions = "--dns 1.1.1.1 --dns 8.8.8.8";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.resolved.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "22.11";
}
