{ pkgs, ... }:
{
  home.packages = with pkgs; [
    python3 # install a default python for common use

    pyright
    ruff
    black
    basedpyright
    python312Packages.debugpy
    python312Packages.python-lsp-server
    uv
  ];
}
