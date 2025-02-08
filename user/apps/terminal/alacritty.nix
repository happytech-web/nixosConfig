{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.85;
        decorations = "None";
        blur = true;
      };
    };
  };
}
