{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshot
  ];

  wayland.windowManager.hyprland.settings.env = [
    "HYPRSHOT_DIR,$HOME/Pictures/screenshot"
  ];
}
