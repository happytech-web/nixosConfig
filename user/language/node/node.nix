{ pkgs, ... }:
{
  home.packages = with pkgs;[
    nodejs_22
    typescript
    typescript-language-server
    vue-language-server
    emmet-ls
    vscode-langservers-extracted
  ];
}
