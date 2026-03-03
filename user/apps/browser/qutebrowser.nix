{ config, pkgs, ... }:
{
  home.packages = [ pkgs.qutebrowser ];

  home.file.".config/qutebrowser/config.py".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/user/apps/browser/config.py";
}
