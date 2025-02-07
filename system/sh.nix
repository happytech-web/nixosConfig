{ config, pkgs, user_settings, ... }:
{
  environment.shells = with pkgs; [ zsh bash ];
  users.defaultUserShell = pkgs.zsh;
  users.users.${user_settings.username}.shell = pkgs.zsh;
  programs.zsh.enable = true;
}
