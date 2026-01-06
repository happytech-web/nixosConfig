{ pkgs, ... }:

{
  # Install the theme package explicitly
  home.packages = [ pkgs.fcitx5-mellow-themes ];

  # Explicitly link themes into ~/.local/share/fcitx5/themes
  xdg.dataFile."fcitx5/themes" = {
    source = "${pkgs.fcitx5-mellow-themes}/share/fcitx5/themes";
    recursive = true;
  };
}
