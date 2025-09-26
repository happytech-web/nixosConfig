# { config, pkgs, ...}:
# {
#   programs.ssh = {
#     enable = true;
#     matchBlocks = {
#       # using ssh in git may cause network related error
#       "github.com" = {
#         hostname = "ssh.github.com";
#         port = 443;
#         user = "git";
#       };
#     };
#   };
# }
#
{ config, pkgs, lib, ... }:
{

  programs.ssh = {
    enable = true;
    matchBlocks = {
      # GitHub 走 443 的 ssh
      "github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
        proxyCommand = "nc -x 127.0.0.1:7897 -X 5 %h %p";
      };

      # 其他所有 SSH 也通过本地 SOCKS5
      "*" = {
        proxyCommand = "nc -x 127.0.0.1:7897 -X 5 %h %p";
      };
    };
  };
}
