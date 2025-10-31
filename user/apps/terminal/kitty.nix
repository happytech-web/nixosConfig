{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty.enable = true;
  programs.kitty.font = {
    package = lib.mkForce pkgs.fira-code;
    name = lib.mkForce "FiraCode";
    size = lib.mkForce 13;
  };
  programs.kitty.settings = {
    # background_opacity = lib.mkForce "0.85";
    cursor_trail = 3;
    cursor_trail_decay = "0.1 0.3";
    cursor_trail_start_threshold = 0;
  };
}
