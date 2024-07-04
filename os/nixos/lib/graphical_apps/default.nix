{ lib, config, pkgs, ... }: 

{
  imports = [
    ./virtual_machines.nix
    ../../../lib/graphical_apps.nix
  ];

  hardware.graphics = {
    enable = true;
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };

  services.geoclue2.enable = true;

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [ swaylock-effects ];
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    disabledPlugins = [ "sap" ];
  };

  services.blueman.enable = true;
  
  security.rtkit.enable = true;
  security.polkit.enable = true;
}
