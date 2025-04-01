{ pkgs, ... } : {
  home.packages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtsvg
  ];
}
