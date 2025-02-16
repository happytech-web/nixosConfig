{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty = lib.mkDefault {
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
