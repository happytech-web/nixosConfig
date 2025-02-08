{ pkgs, ... }:
{
  home.packages = with pkgs; [
    temurin-bin
    jetbrains.idea-community
  ];
}
