{ pkgs, ... }:
{
  home.packages = with pkgs; [
    postman
    qq
    wpsoffice
  ];
}
