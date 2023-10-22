{ inputs, outputs, lib, config, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users.users = {
    will = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEd+kmG9ScsNZZtqNRnhsBIBBSM5sv/ma8cuHTjGU6UQ wf8581@gmail.com" # mbp
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3E5qb0rP7crUGLtOoztcPvXZ42P8QQMNXZrNXDxWKi wf8581@gmail.com" # desktop
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSSsTq5FjE5T6k0XYjulF89EHiYl4XRt9sMuIE7ah0N wf8581@gmail.com" # dev
      ];
      extraGroups = [ "wheel" "docker" "sound" "libvirtd" ];
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  networking.firewall = {
    enable = false;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ ];
    checkReversePath = "loose";
  };

  networking = {
    # nameservers = [
    #   "100.100.100.100"
    #   "1.1.1.1"
    # ];

    search = [ "tail8135e.ts.net" ];
  };

  services.resolved.enable = true;

  system.stateVersion = "22.11";
}
