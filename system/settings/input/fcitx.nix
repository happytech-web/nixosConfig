{ pkgs, ...}: {

  # without this, some apps like emacs cannot use fcitx
  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    FCITX5_ENABLE_WAYLAND = "true";
  };

  environment.systemPackages = with pkgs; [
    fcitx5-configtool
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          (fcitx5-rime.override {
            rimeDataPkgs = [
              rime-data
              rime-ice
            ];
          })
          fcitx5-chinese-addons
          # qt6Packages.fcitx5-chinese-addons
          # fcitx5-nord
          # hello
          #
        ];
      };
    };
  };
}
