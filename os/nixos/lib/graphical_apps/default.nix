{ lib, config, pkgs, ... }: 

{
  fonts.fonts = with pkgs; [
    jetbrains-mono
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  environment.systemPackages = with pkgs; [
    glfw-wayland
  ];
}
