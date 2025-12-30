{ pkgs, ... } :
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      # Only add GTK here; Hyprland portal is provided via programs.hyprland.portalPackage
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

      # Prefer GTK for dialogs; use Hyprland for screen APIs
      config = {
        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
          "org.freedesktop.impl.portal.Screencast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        };
        hyprland = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.Screencast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        };
      };
    };
  };
}
