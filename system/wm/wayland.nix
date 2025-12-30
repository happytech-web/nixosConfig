{pkgs, global_utils, ...}:
{
  imports = map (file: global_utils.system_path + file) [
    # include sddm to greet user
    /sddm/sddm.nix
    /settings/keyring/gnome-keyring.nix
  ];

  environment.variables = {
    # Enable Wayland for Firefox; Chromium uses NIXOS_OZONE_WL
    MOZ_ENABLE_WAYLAND = "1";
    # NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
  };



  # configure xwayland
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "ctrl:swapcaps";
}
