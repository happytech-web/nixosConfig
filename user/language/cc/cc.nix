{ pkgs, global_utils, ... }:
{
  home.packages = with pkgs; [
    gcc

    gnumake
    cmake

    cmake-language-server
    global_utils.pkgs-unstable.clang-tools

    compiledb

    valgrind-light
    gdb
    pkgs.lldb
    (pkgs.writeShellScriptBin "codelldb" ''
      exec "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb" "$@"
    '')
  ];
}
