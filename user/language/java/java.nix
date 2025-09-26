{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk24
    jetbrains.idea-community-bin
    jetbrains.idea-ultimate
    # install it for emacs, but emacs just don't use it. lsp-java want to install it in emacs.d
    # btw, you need to set export MAVEN_OPTS="-DsocksProxyHost=127.0.0.1 -DsocksProxyPort=7897" to install it succesfully in emacs
    jdt-language-server
    gradle
    prettierd
  ];

  # link .jdk to my jdks. this can let idea find proper jdk
  home.file.".jdk/jdk8".source = pkgs.jdk8;
  home.file.".jdk/jdk11".source = pkgs.jdk11;
  home.file.".jdk/temurin-jre-17".source = pkgs.temurin-jre-bin-17;
  home.file.".jdk/jdk24".source = pkgs.jdk24;

  programs.gradle = {
    enable = true;
    settings = {
      # HTTP 代理
      "systemProp.http.proxyHost"    = "127.0.0.1";
      "systemProp.http.proxyPort"    = "7897";
      # HTTPS 代理
      "systemProp.https.proxyHost"   = "127.0.0.1";
      "systemProp.https.proxyPort"   = "7897";
      # （可选）不走代理的主机
      "systemProp.http.nonProxyHosts" = "localhost|127.0.0.1";
    };
  };
}
