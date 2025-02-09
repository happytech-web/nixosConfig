{ pkgs, ... }:
{
  imports = [
    ./wayland.nix # sddm and keymap in xwayland

  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    # dont worry xdg-desktop-protal-hyprland, hyprland.enable already do it for us
  };
}
