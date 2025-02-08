{ pkgs, global_utils, ... }:
{
  imports = map (file: global_utils.system_path + file) [
    # include sddm to greet user
    /sddm/sddm.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "ctrl:swapcaps";

}
