{ inputs, outputs, lib, config, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
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

  networking.nftables.enable = true;
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
  services.udisks2.enable = true;

  # Temporary service to fix ethernet going down
  # after a few minutes
  systemd.services.resetNetworkInterface = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    description = "Reset network interface if internet goes down";
    scriptArgs = "eno1";
    script = ''
      sleep 30 # Don't need to start checking right away
      net_int=$1

      while true; do
        if ${pkgs.wget}/bin/wget -q --spider www.google.com; then
          sleep 2
        else
          echo "Restarting $net_int"
          ${pkgs.iproute2}/bin/ip link set $net_int down
          sleep 3
          ${pkgs.iproute2}/bin/ip link set $net_int up
          sleep 30
        fi
      done
    '';
  };

  system.stateVersion = "22.11";
}
