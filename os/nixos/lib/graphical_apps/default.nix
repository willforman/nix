{ lib, config, pkgs, ... }: 

{
  fonts.fonts = with pkgs; [
    jetbrains-mono
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };

  environment.systemPackages = with pkgs; [
    glfw-wayland
  ];
}
