{pkgs, ...}:
{
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
    graphviz
    ghostscript
    xhost
    zathura
  ];

  programs.zathura = {
    enable = true;
    extraConfig = ''
      map <C-j> navigate next
      map <C-k> navigate previous
      map H adjust_window best-fit
      map W adjust_window width
      map = zoom in
      map - zoom out

      set selection-clipboard clipboard
    '';
  };
}
