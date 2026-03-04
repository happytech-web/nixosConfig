{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      source-file ${config.xdg.configHome}/tmux/tmux.conf
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

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  xdg.configFile."tmux/fzf_panes.sh".source = ./fzf_panes.sh;
  xdg.configFile."tmux/scripts".source = ./scripts;

}
