{ config, pkgs, ...}:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      # using ssh in git may cause network related error
      "github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
      };
    };
  };
}
  
