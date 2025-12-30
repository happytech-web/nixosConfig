{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pyright
    ruff
    basedpyright
    python312Packages.debugpy
    python312Packages.python-lsp-server
    uv
  ];
}
