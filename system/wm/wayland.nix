{pkgs, global_utils, ...}:
{
  imports = map (file: global_utils.system_path + file) [
    # include sddm to greet user
    /sddm/sddm.nix
  ];

  # configure xwayland
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "ctrl:swapcaps";
}
