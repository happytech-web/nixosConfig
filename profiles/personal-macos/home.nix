{ pkgs, user_settings, global_utils, ... }:

{
  imports = map (file: global_utils.user_path + file) [
    /style/stylix.nix
    /shell/sh.nix
    /shell/cli_apps.nix
    /apps/git/git.nix
    /apps/apps_collection/yazi.nix
    /apps/terminal/kitty.nix
    /apps/terminal/tmux/tmux.nix
    /apps/editor/neovim/neovim.nix
    /apps/editor/vim/vim.nix


    /language/latex/latex.nix
    /language/python/python.nix
    /graphics/wm/aerospace/aerospace.nix
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
