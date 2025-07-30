{pkgs, ...}:
{
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    graphviz
    ghostscript
  ];
}
