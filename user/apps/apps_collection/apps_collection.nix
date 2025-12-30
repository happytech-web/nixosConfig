{ pkgs, global_utils, ... }:
{
  home.packages = with pkgs; [
    postman
    wpsoffice-cn
    zed-editor
    gimp
    # qq
  ] ++ [
    global_utils.pkgs-unstable.qq
    global_utils.pkgs-unstable.wemeet
  ];
}
