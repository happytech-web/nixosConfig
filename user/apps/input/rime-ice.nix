{ pkgs, ... }:

{
  # make sure you have install the rime ice in system level

  xdg.dataFile."fcitx5/rime/default.custom.yaml".text = ''
    patch:
      __include: rime_ice_suggestion:/
      menu:
        page_size: 9
  '';

}
