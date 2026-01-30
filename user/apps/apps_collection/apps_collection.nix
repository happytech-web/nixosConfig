{ pkgs, global_utils, ... }:
{
  home.packages = with pkgs; [
    # postman
    wpsoffice-cn
    zed-editor
    # gimp
  ] ++ [
    global_utils.pkgs-unstable.qq
    global_utils.pkgs-unstable.wemeet
  ];

  # Provide a user-level desktop entry that forces Wayland flags
  # xdg.desktopEntries.qq = {
  #   name = "QQ";
  #   comment = "Tencent QQ";
  #   icon = "qq";
  #   exec = "qq --enable-wayland-ime --ozone-platform=wayland --ozone-platform-hint=auto %U";
  #   terminal = false;
  #   categories = [ "Network" "InstantMessaging" ];
  # };
}
