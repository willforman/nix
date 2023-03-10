{ config, pkgs, lib, ... }:

let 
  ethInterfaceName = "enp0s20f0u2";
  wireGuard = {
    port = 51820;
    path = config.users.users.will.home + "/.local/share/wireguard/";
  };
in
{
  networking.nat = {
    enable = true;
    externalInterface = ethInterfaceName;
    internalInterfaces = [ "wg0" ];
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.1/24" ];
      listenPort = wireGuard.port;
      privateKeyFile = "/home/will/.local/share/wireguard/private";#wireGuard.path + "private";

      postUp = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o ${ethInterfaceName} -j MASQUERADE
      '';

      postDown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o ${ethInterfaceName} -j MASQUERADE
      '';

      peers = [
        {
          # mbp
          publicKey = "Re8xcM/UKyhGNGpvyByPzReXqxgbTXfIi2aDjshXJ30=";
          allowedIPs = [ "10.0.0.2/32" ];
        }
      ];
    };
  };

  services.adguardhome = {
    enable = false;
    mutableSettings = false;

    settings = {
      bind_host = "192.168.0.7";
      bind_port = 3000;
      users = [{ 
        name = "admin";
        password = "$2y$12$R4rurnN8wct96hOKWaAdIedKZ9DPUJQcgcbPlukQx2VwVuL7fRVga";
      }];
      dns = {
        bind_hosts = [ "192.168.0.7" ];
        port = 53;
        bootstrap_dns = 
          [ "9.9.9.10" "149.112.112.10" "2620:fe::10" "2620:fe::fe:10" ];
      };
    };
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "wg0" "tailscale0" ];
    allowedUDPPorts = [ wireGuard.port config.services.tailscale.port ];
    allowedTCPPorts = [ 22 ];
    checkReversePath = "loose";
  };
}
