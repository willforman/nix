{ config, pkgs, lib, ... }:

let 
  wireGuard = {
    port = 51820;
    path = config.users.users.will.home + ".local/share/wireguard/";
    ip = "10.100.0.2/24";
  };
in
{

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ wireGuard.ip ];
      listenPort = wireGuard.port;
      privateKeyFile = wireGuard.path + "private";

      peers = [
        {
          publicKey = "ITHN5/JXMjWLeFOhSf4dnNu1eIDqNByjH5XrrZeXH3o=";
          allowedIPs = [ "10.100.0.1/32" ];
          endpoint = "${wireGuard.ip}" + ":" + "${wireGuard.port}";
          persistentKeepAlive = 25;
        }
      ];
    };
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ ];
    allowedUDPPorts = [ wireGuard.port ];
    allowedTCPPorts = [ ];
  };
}
