{ pkgs, global_utils, ... }:
{
  home.packages = with pkgs; [
    postman
    wpsoffice
    zed-editor
    gimp
    qq
  ] ++ [
    # global_utils.pkgs-unstable.qq
  ];
}
