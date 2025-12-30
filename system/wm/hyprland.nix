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

  # Ensure session identifies as Hyprland for portals
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    DESKTOP_SESSION = "hyprland";
  };
}
