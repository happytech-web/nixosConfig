{ pkgs, ... }:
{
  imports = [
    ./py-package.nix
  ];
  home.packages = with pkgs; [
    python3Full
    pyright
  ];
}
