{ config, pkgs, lib, user_settings, global_utils, ... }:

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
    /apps/browser/qutebrowser.nix
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

    # /graphics/wm/hyprland/hyprland.nix
    /graphics/wm/niri/niri.nix
  ];

  home.username = user_settings.username;
  home.homeDirectory = "/home/" + user_settings.username;

  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Fix deprecated 'nix profile install' → 'nix profile add'
  # Remove this override once home-manager upstream fixes it.
  home.activation.installPackages = lib.mkForce (lib.hm.dag.entryAfter [ "writeBoundary" ] (
    if config.submoduleSupport.externalPackageInstall then
      ''nixProfileRemove home-manager-path''
    else
      let cfg = config.home; in ''
        function nixReplaceProfile() {
          local oldNix="$(command -v nix)"
          nixProfileRemove 'home-manager-path'
          run $oldNix profile add $1
        }
        if [[ -e ${cfg.profileDirectory}/manifest.json ]] ; then
          INSTALL_CMD="nix profile add"
          INSTALL_CMD_ACTUAL="nixReplaceProfile"
          LIST_CMD="nix profile list"
          REMOVE_CMD_SYNTAX='nix profile remove {number | store path}'
        else
          INSTALL_CMD="nix-env -i"
          INSTALL_CMD_ACTUAL="run nix-env -i"
          LIST_CMD="nix-env -q"
          REMOVE_CMD_SYNTAX='nix-env -e {package name}'
        fi
        if ! $INSTALL_CMD_ACTUAL ${cfg.path} ; then
          echo
          _iError $'Oops, Nix failed to install your new Home Manager profile!\n\nPerhaps there is a conflict with a package that was installed using\n"%s"? Try running\n\n    %s\n\nand if there is a conflicting package you can remove it with\n\n    %s\n\nThen try activating your Home Manager configuration again.' "$INSTALL_CMD" "$LIST_CMD" "$REMOVE_CMD_SYNTAX"
          exit 1
        fi
        unset -f nixReplaceProfile
        unset INSTALL_CMD INSTALL_CMD_ACTUAL LIST_CMD REMOVE_CMD_SYNTAX
      ''
  ));
}
