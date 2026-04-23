{ pkgs, global_utils,... }:
{
  home.packages = with pkgs; [
    texliveFull
    global_utils.pkgs-unstable.typst
    tinymist
  ];
}
