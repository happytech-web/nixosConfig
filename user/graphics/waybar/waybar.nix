{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

}
