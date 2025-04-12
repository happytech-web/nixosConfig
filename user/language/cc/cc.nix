{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    cmake

    cmake-language-server
    clang-tools
    clang

    python312Packages.compiledb

    valgrind-light
    gdb
    lldb
  ];
}
