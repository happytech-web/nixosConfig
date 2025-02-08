{ pkgs, ... }:
{
  # collection of my CLI apps
  home.packages = with pkgs; [
    disfetch fastfetch
    rnr
    pandoc
    tlrc
    tree
  ];
}
