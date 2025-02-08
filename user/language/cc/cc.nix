{ pkg, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    cmake
    clang-tools
    compiledb
  ];
}
