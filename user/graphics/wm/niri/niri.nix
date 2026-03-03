{ lib, pkgs, global_utils, config, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{

  imports = map (file: global_utils.user_path + file) [
    # user folder
    /graphics/basic-utils/network-manager/nm-applet.nix
    /graphics/basic-utils/blueman/blueman.nix
    /graphics/basic-utils/clipboard/wl-clipboard.nix
    /graphics/basic-utils/clipboard/cliphist.nix
    /graphics/basic-utils/brightness/brightnessctl.nix
    /graphics/basic-utils/keyring/gnome-keyring.nix
    /graphics/basic-utils/file-manager/dolphin.nix
    /graphics/basic-utils/polkit/polkit.nix


    /graphics/shell/noctalia/noctalia.nix
  ];

  home.pointerCursor = lib.mkDefault {
    package = pkgs.bibata-cursors;
    size = 24;
    name = "Bibata-Modern-Classic";
    gtk = {
      enable = true;
    };
  };

  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    size = 24;
    name = "Bibata-Modern-Classic";
  };

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".text = lib.replaceStrings
    [
      "__ACTIVE_COLOR__"
      "__INACTIVE_COLOR__"
      "__URGENT_COLOR__"
      "__TAB_ACTIVE_COLOR__"
    ]
    [
      colors.base0D
      colors.base03
      colors.base09
      "#29e8ab"
    ]
    (builtins.readFile ./config.kdl);
}
