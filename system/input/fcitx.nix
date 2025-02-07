{ pkgs, ...}: {
  i18n = {
    # 
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-rime
          fcitx5-chinese-addons
          # fcitx5-nord
        ];
      };
    };
  };
}
