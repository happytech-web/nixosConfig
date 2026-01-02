{ pkgs, ... }:

{
  # Place Rime user config for fcitx5 under XDG data dir
  # Enables rime-ice upstream suggestion defaults
  xdg.dataFile."fcitx5/rime/default.custom.yaml".text = ''
    patch:
      __include: rime_ice_suggestion:/
  '';

  # Optional: ensure rime-ice is available in PATH/store for reference
  # Not strictly required if system fcitx5-rime already includes rime-ice
  # home.packages = [ pkgs.rime-ice ];
}

