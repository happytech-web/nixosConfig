{ pkgs, global_utils, ... }:
{
  imports = map (file: global_utils.user_path + file) [
    /graphics/network-manager/nm-applet.nix
    /graphics/blueman/blueman.nix

    /graphics/lock/hyprlock.nix
    /graphics/waybar/waybar.nix
    /graphics/app-launcher/wofi.nix
  ];

  # not work
  nixpkgs.config.allowUnfree = true;
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--ozone-platform-hint=auto"
    ];
  };

  # hypridle
  home.packages = with pkgs; [
    hypridle
  ];

  services.hypridle.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enableXdgAutostart = true;
    settings = {
      env = [
        "XMODIFIERS, @im=fcitx"
        "QT_IM_MODULE, fcitx"
        "SDL_IM_MODULE, fcitx"
        "GDK_BACKEND, wayland,x11"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE-FACTOR, 1"
        "CLUTTER_BACKEND, wayland"
        "ADW_DISABLE_PROTAL, 1"
        "XCURSOR_SIZE, 24"
      ];
    # **基础设置**
      monitor = ",preferred,auto,auto";
      general = {
        gaps_in = 5;
        gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgb(89b4fa)";
      "col.inactive_border" = "rgb(45475a)";
    };
      
      input = {
        kb_layout = "us";
        kb_options = "ctrl:swapcaps";
        follow_mouse = 1;
        sensitivity = 0;
      };
      
      # **最小化 keybinding，防止进不了桌面**
      bind = [
        "SUPER, Return, exec, alacritty" # 打开终端
        "SUPER, Q, killactive" # 关闭窗口
        "SUPER, D, exec, wofi --show drun" # 启动应用
        "SUPER, L, exec, hyprlock" # 锁屏

      # **默认工作区**
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
      ];
      
      # **默认应用**
      exec-once = [
        "waybar"
        "dunst" # Wayland 通知服务
        "fcitx5" # 输入法
      ];
    };
  };

}
