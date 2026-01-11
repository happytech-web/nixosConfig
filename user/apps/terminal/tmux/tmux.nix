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

  # xdg.confileFile."tmux/scripts".source = {
  #   source = "${tmux_path}" + "scripts";
  # };

  # Symlink ~/.tmux.conf -> ~/.dotfiles/user/apps/terminal/tmux/tmux.conf
  # xdg.configFile."tmux/.tmux.conf".source =
  #   config.lib.file.mkOutOfStoreSymlink (
  #     # global_utils.user_path + "/user/apps/terminal/tmux/tmux.conf"
  #     tmux_path + "tmux.conf"
  #   );

  # Symlink helper script into ~/.config/tmux for a stable, non-store path
  # xdg.configFile."tmux/fzf_panes.sh".source =
  #   config.lib.file.mkOutOfStoreSymlink (
  #     tmux_path + "fzf_panes.sh"
  #   );
}
