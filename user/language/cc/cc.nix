{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc

    gnumake
    cmake

    cmake-language-server
    clang-tools

    compiledb

    valgrind-light
    gdb
    lldb
  ];
}
