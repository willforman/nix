{ lib, config, pkgs, ... }: 

{
  imports = [
    ./virtual_machines.nix
    ../../../lib/graphical_apps.nix
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
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
}
