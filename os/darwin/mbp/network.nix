{ config, pkgs, lib, ... }:

let 
  wireGuard = {
    port = 51820;
    path = config.users.users.will.home + "/.local/share/wireguard/";
    ip = "10.0.0.2/24";
  };
in
{
  # networking.wg-quick.interfaces = {
  #   wg0 = {
  #     address = [ wireGuard.ip ];
  #     listenPort = wireGuard.port;
  #     privateKeyFile = "/Users/will/.local/share/wireguard/private";#wireGuard.path + "private";
  #
  #     peers = [
  #       {
  #         publicKey = "ITHN5/JXMjWLeFOhSf4dnNu1eIDqNByjH5XrrZeXH3o=";
  #         allowedIPs = [ "10.0.0.1/32" ];
  #         endpoint = "192.168.0.7:" + toString wireGuard.port;
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };
}
