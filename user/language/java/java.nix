{ pkgs, ... }:
{
  home.packages = with pkgs; [
    temurin-bin
    jetbrains.idea-community-bin
    # install it for emacs, but emacs just don't use it. lsp-java want to install it in emacs.d
    # btw, you need to set export MAVEN_OPTS="-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=7897" to install it succesfully in emacs
    jdt-language-server
  ];
}
