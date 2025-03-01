{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk11
    jetbrains.idea-community-bin
    # install it for emacs, but emacs just don't use it. lsp-java want to install it in emacs.d
    # btw, you need to set export MAVEN_OPTS="-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=7897" to install it succesfully in emacs
    jdt-language-server
  ];

  # link .jdk to my jdks. this can let idea find proper jdk
  home.file.".jdk/jdk8".source = pkgs.jdk8;
  home.file.".jdk/jdk11".source = pkgs.jdk11;
  home.file.".jdk/temurin-jre-17".source = pkgs.temurin-jre-bin-17;
}
