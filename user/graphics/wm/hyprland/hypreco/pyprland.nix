{ pkgs, ... } :
{
  home.packages = with pkgs; [
    pyprland
  ];
  home.file.".config/hypr/pyprland.toml".text = ''
  [pyprland]
  plugins = ["scratchpads"]

  [scratchpads]
  [scratchpads.term]
  animation = "fromTop"
  command = "kitty --class kitty-dropterm"
  class = "kitty-dropterm"
  position = "14% 18%"
  size = "75% 60%"
  max_size = "1920px 100%"
  margin = 50

  [scratchpads.yazi]
  animation = "fromTop"
  command = "kitty --class yazi-launcher yazi"
  class = "yazi-launcher"
  position = "14% 18%"
  size = "75% 60%"
  margin = 0
  unfocus = "hide"
  '';
}
