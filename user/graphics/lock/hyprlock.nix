{ pkgs , ... }:
{
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock.enable = true;
}
