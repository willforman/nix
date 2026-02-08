{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev:
    (inputs.claude-code.overlays.default final prev);
}
