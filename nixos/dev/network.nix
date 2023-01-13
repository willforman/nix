{ config, pkgs, lib, ... }:

{
  services.tailscale = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.tailscale ];

  services.adguardhome = {
    enable = true;
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
    trustedInterfaces = [ 
      "tailscale0"
      "enp0s20f0u2"
    ];
    allowedUDPPorts = [ 
      config.services.tailscale.port
      config.services.adguardhome.settings.dns.port
    ];
    allowedTCPPorts = [ 
      22
      config.services.adguardhome.settings.bind_port
    ];
    
    # Got warning: "Tailscale reverse path filtering breaks tailscale exit node use and some subnet routing setups"
    checkReversePath = "loose";
  };
}
