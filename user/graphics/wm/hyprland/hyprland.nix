{ pkgs, global_utils, ... }:
{
  imports = map (file: global_utils.user_path + file) [
    # user folder
    /graphics/network-manager/nm-applet.nix
    /graphics/blueman/blueman.nix

    /graphics/lock/hyprlock.nix
    /graphics/waybar/waybar.nix
    /graphics/app-launcher/wofi.nix

  ] ++ [
    # relative path
    ./hyprpaper.nix
  ];

  # hypridle
  home.packages = with pkgs; [
    hypridle
  ];


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
      
      # configure the monitor
      monitor = ",preferred,auto,auto";

      general = {
        layout = "master";
        gaps_in = 7;
        gaps_out = 7;
        border_size = 5;
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(45475a)";
        resize_on_border = true;
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          contrast = 1.17;
          xray = true;
          popups = true;
        };
      };

      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.0"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
        "linear, 0.0, 0.0, 1.0, 1.0"
      ];

      animations =  {
           enabled = true;
           animation = [
             "windowsIn, 1, 6, winIn, popin"
             "windowsOut, 1, 5, winOut, popin"
             "windowsMove, 1, 5, wind, slide"
             "border, 1, 10, default"
             "borderangle, 1, 100, linear, loop"
             "fade, 1, 10, default"
             "workspaces, 1, 5, wind"
             "windows, 1, 6, wind, slide"
             "specialWorkspace, 1, 6, default, slidefadevert -50%"
           ];
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
        "SUPER, D, exec, wofi --show run" # 启动应用
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
        "systemctl --user enable -now hyprpaper.service" # hyprpaper
      ];
    };
  };

}
