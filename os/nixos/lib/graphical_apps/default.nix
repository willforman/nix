{ lib, config, pkgs, ... }: 

{
  imports = [
    ./virtual_machines.nix
  ];
  fonts.fonts = with pkgs; [
    jetbrains-mono
    gyre-fonts
    libertinus
    noto-fonts-emoji
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  security.pam.services.swaylock = {
    text = "auth include login";
  };

  services.geoclue2.enable = true;

  environment.systemPackages = with pkgs; [
    glfw-wayland
  ];
}
