{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python3Full
    pyright
    ruff
    basedpyright
    python312Packages.debugpy
  ];
}
