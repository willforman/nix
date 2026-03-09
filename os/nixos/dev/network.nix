{ config, pkgs, lib, ... }:
{
  networking.interfaces.enp0s20f0u2c2 = {
    useDHCP = false;
    ipv4.addresses = [{
      address = "192.168.1.7";
      prefixLength = 24;
    }];
  };
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "9.9.9.10" "149.112.112.10" ];

  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    openFirewall = true;

    host = "0.0.0.0";
    port = 3000;

    settings = {
      users = [{ 
        name = "admin";
        password = "$2y$05$M4mvpCUW.42d6F4IBgdsM.BsdxiP4WmkbDq4hGayQW09dc40HOunO";
      }];
      dns = {
        bind_hosts = [ "192.168.1.7" ];
        port = 53;
        bootstrap_dns = 
          [ "9.9.9.10" "149.112.112.10" "2620:fe::10" "2620:fe::fe:10" ];
      };
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ 
      53 # DNS resolver port for adguardhome
    ];
  };
}
