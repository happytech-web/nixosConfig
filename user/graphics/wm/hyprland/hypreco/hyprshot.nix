{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshot
  ];
  wayland.windowManager.hyprland.settings.env = [
    "HYPRSHOT_DIR, /home/happytech/Pictures/screenshot"
  ];
}
