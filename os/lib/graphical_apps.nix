{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    gyre-fonts
    libertinus
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
