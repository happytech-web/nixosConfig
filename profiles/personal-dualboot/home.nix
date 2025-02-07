{ config, pkgs, user_settings, global_utils, ... }:

{

  imports = map (file: global_utils.user_path + file) [
    /shell/sh.nix # shell configuration
    /shell/cli_apps.nix
    /apps/git/git.nix
    /apps/vim/vim.nix
    /network/ssh.nix
  ];

  home.username = user_settings.username;
  home.homeDirectory = "/home/" + user_settings.username;

  home.stateVersion = "24.11"; 

  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
