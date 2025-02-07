{ config, pkgs, ... }:
{
  environment.shells = with pkgs; [ zsh bash ];
  users.defaultUserShell = pkgs.zsh;
  users.users.happytech.shell = pkgs.zsh;
  programs.zsh.enable = true;
}
