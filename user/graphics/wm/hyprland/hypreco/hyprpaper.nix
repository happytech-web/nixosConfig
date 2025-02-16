{ pkgs, lib,... }:
let
  wallpaper_path = "/home/happytech/.dotfiles/themes/moonlight/background.jpg";
in
{

  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper
  services.hypridle.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = lib.mkDefault {
      ipc = "on";
      splash = true;
      splash_offset = 0.0;
      
      preload =
        [ wallpaper_path ];
      
      wallpaper = [
        (", " + wallpaper_path)
      ];
    };
  };
}
