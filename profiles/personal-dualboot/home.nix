{ config, pkgs, user_settings, global_utils, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = map (file: global_utils.user_path + file) [
    # settings
    /settings/session.nix

    # theme
    /style/stylix.nix

    # core
    /shell/sh.nix # shell configuration
    /shell/cli_apps.nix
    /apps/git/git.nix
    /apps/terminal/kitty.nix
    /apps/terminal/alacritty.nix
    /apps/terminal/tmux/tmux.nix

    /apps/editor/emacs/emacs.nix
    /apps/editor/neovim/neovim.nix
    /apps/editor/vim/vim.nix

    /apps/browser/firefox.nix
    /apps/tmp/apps.nix
    /apps/apps_collection/apps_collection.nix
    /apps/apps_collection/yazi.nix
    /apps/apps_collection/codex.nix

    /apps/input/rime-ice.nix
    /apps/input/fcitx5-mellow.nix


    /network/ssh.nix
    /language/cc/cc.nix
    /language/python/python.nix
    /language/java/java.nix
    /language/latex/latex.nix
    /language/node/node.nix
    /language/rust/rust.nix

    /graphics/wm/hyprland/hyprland.nix
  ];

  home.username = user_settings.username;
  home.homeDirectory = "/home/" + user_settings.username;

  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
