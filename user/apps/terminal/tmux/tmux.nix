{ config, lib, pkgs, global_utils, ... }:
{
  programs.tmux.enable = true;

  # Symlink ~/.tmux.conf -> ~/.dotfiles/user/apps/terminal/tmux.conf
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink (
      global_utils.user_path + "/user/apps/terminal/tmux.conf"
    );
}
