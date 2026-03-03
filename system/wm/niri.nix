{ pkgs, ... }:
{
  imports = [
    ./wayland.nix # sddm and keymap in xwayland
  ];

  programs.niri = {
    enable = true;
  };
}
