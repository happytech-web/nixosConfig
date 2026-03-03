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

    # --- Dark mode (recolor) ---
    set recolor false              # 默认正常颜色
    set recolor-keephue true       # 图片/公式不乱色
    set recolor-darkcolor "#1e1e2e"
    set recolor-lightcolor "#cdd6f4"

    # toggle dark mode
    map t set recolor toggle
    '';
  };
}
