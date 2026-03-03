{ config, lib, pkgs, global_utils, ... }:
let
  tmux_path = "${config.home.homeDirectory}/.dotfiles/user/apps/terminal/tmux/";
in
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      source-file ${tmux_path + "tmux.conf"}
    '';
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.rose-pine;
        extraConfig = ''
          set -g @plugin 'rose-pine/tmux'
          set -g @rose_pine_variant 'main'
        '';
      }
    ];
  };

}
