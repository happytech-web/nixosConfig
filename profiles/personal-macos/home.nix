{ pkgs, user_settings, global_utils, ... }:

{
  imports = map (file: global_utils.user_path + file) [
    /shell/sh.nix
    /apps/git/git.nix
    /apps/terminal/kitty.nix
    /apps/terminal/tmux/tmux.nix
    /apps/editor/neovim/neovim.nix
    /apps/editor/vim/vim.nix
  ];

  home.username = user_settings.username;
  home.homeDirectory = user_settings.homeDirectory;

  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    coreutils
    gawk
    gnugrep
    gnused
  ];

  programs.home-manager.enable = true;
}
