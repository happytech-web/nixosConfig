{ pkgs, global_utils, ... }:
{
  imports = map (file: global_utils.user_path + file) [
    /graphics/network-manager/nm-applet.nix
    /graphics/blueman/blueman.nix

    /graphics/lock/hyprlock.nix
    /graphics/waybar/waybar.nix
  ];

  # hypridle
  home.packages = with pkgs; [
    hypridle
  ];

  services.hypridle.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enableXdgAutostart = true;
  };

}
