{ pkgs, ... }:
{
  home.packages = with pkgs.python3Packages; [
    openai
  ];
}
