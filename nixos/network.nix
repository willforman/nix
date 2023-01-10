{ config, pkgs, lib, ... }:

{
  services.tailscale = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    allowedTCPPorts = [ 22 ];
    
    # Got warning: "Tailscale reverse path filtering breaks tailscale exit node use and some subnet routing setups"
    checkReversePath = "loose";
  };
}
