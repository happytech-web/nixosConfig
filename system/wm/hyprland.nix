{ pkgs, ... }:
{
  imports = [
    ./wayland.nix # sddm and keymap in xwayland

  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
