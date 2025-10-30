{ pkgs, lib, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    gyre-fonts
    libertinus
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];
}
