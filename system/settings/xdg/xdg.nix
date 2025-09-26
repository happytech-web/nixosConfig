{ pkgs, ... } :
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
        hyprland = {
          default = ["hyprland" "gtk" "kde"];
          "org.freedesktop.impl.portal.FileChooser" = [
            "kde"
          ];
          "org.freedesktop.impl.portal.OpenURI" = [
            "kde"
          ];
          "org.freedesktop.impl.portal.FilePicker" = [
            "kde"
          ];
        };
      };
    };
  };
}
