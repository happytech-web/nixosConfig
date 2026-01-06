{ config, lib, pkgs, global_utils, ... }:
{
  programs.tmux.enable = true;

  # Symlink ~/.tmux.conf -> ~/.dotfiles/user/apps/terminal/tmux/tmux.conf
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink (
      global_utils.user_path + "/apps/terminal/tmux/tmux.conf"
    );

  # Install the fzf panes helper as a PATH binary
  # to avoid hardcoding any user-specific paths in tmux.conf
  home.packages = [
    (pkgs.writeShellScriptBin "fzf-panes-tmux"
      (builtins.readFile (
        global_utils.user_path + "/apps/terminal/tmux/fzf_panes.sh"
      )))
  ];
}
