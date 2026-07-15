{ pkgs, ... } :
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      # WM-specific portal packages are provided by their NixOS modules.
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

      # Prefer GTK for dialogs; use the compositor portal for screen APIs.
      config = {
        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
        };
        niri = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        };
        hyprland = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        };
      };
    };
  };
}
