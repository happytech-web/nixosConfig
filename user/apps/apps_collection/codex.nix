{ config, pkgs, global_utils, lib, ... }:
{
  programs.codex = {
    enable = true;
    package = global_utils.pkgs-unstable.codex;
    settings = {
      mcp_servers = {
        git = {
          command = "uvx";
          args = ["mcp-server-git"];
        };
      };
    };
  };

  programs.opencode = {
    enable = true;
    package = global_utils.pkgs-unstable.opencode;
  };
}
