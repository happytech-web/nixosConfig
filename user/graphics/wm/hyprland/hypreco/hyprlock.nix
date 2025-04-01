{ pkgs, ... } :
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background.blur_passes = 2;
    };
  };
}
