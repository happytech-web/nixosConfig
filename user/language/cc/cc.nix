{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    cmake
    clang-tools
    python312Packages.compiledb
  ];
}
