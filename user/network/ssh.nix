{ config, pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  home.file.".ssh/config".text = ''
Host github.com
  HostName ssh.github.com
  Port 443
  User git
  ProxyCommand nc -x 127.0.0.1:7897 -X 5 %h %p

Host *

Include ~/.ssh/config.d/*.conf
  '';

  home.file.".ssh/config.d".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/user/network/config/ssh";

  home.packages = with pkgs; [
    sshfs
  ];
}
