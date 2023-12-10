{ config, pkgs, lib, ... }:
{
  services.udiskie.enable = true;

  services.gpg-agent = {
    enable = true;
  };
}
