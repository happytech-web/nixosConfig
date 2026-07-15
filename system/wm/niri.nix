{ pkgs, global_utils, ... }:
{
  imports = [
    ./wayland.nix # sddm and keymap in xwayland
  ];

  programs.niri = {
    enable = true;
    package = global_utils.pkgs-unstable.niri;
  };
}
