{ lib, pkgs, global_utils, ... }:
let
  systemd_session = "hyprland-session.target";
  start_workspace = 500000;
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

    /graphics/lock/hyprlock.nix
    /graphics/waybar/waybar.nix
    /graphics/app-launcher/wofi.nix

  ] ++ [
    # relative path
    ./hypreco/hyprpaper.nix
    ./hypreco/hyprshot.nix
  ];

  
  programs.waybar.systemd.target = systemd_session;
  services.cliphist.systemdTarget = systemd_session;

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

  # hypridle
  home.packages = with pkgs; [
    hypridle
    hyprnome
    hyprcursor
    bibata-cursors
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };
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

        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
      ];
      
      # configure the monitor
      monitor = ",preferred,auto,auto";

      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = "0, 5, 5, 5";
        border_size = 3;
        "col.active_border" = lib.mkDefault "rgb(89b4fa)";
        "col.inactive_border" = lib.mkDefault "rgb(45475a)";
        resize_on_border = true;
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
          contrast = 1.17;
          xray = true;
          # popups = true;
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
        # key
        kb_layout = "us";
        kb_options = "ctrl:swapcaps";
        numlock_by_default = true;
        repeat_rate = 45;
        repeat_delay = 400;

        # mouse
        follow_mouse = 1;
        sensitivity = 0;
        natural_scroll = true;

        # touch pad
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.8;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "(Alacritty)|(kitty)";
      };

      xwayland = {
        force_zero_scaling = true;
      };

      cursor = {
        inactive_timeout = 30;
      };
      
      bind = [
        # === app launching ===
        "SUPER, Return, exec, uwsm app -- kitty" # 打开终端
        "SUPER, Q, killactive" # 关闭窗口
        # "SUPER, D, exec, wofi --show run" # 启动应用
        "SUPER, D, exec, uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)" # 启动应用
        "SUPER, A, exec, uwsm app -- emacsclient -c -a 'emacs'"
        "SUPER, S, exec, uwsm app -- google-chrome-stable --enable-wayland-ime --ozone-platform=wayland --ozone-platform-hint=auto"

        # === window managing ===
        # full screen
        "SUPER,Backspace,fullscreen,1"
        "SUPERCTRL,Backspace,fullscreen,0"
        # move
        "SUPER,H,movefocus,l"
        "SUPER,J,movefocus,d"
        "SUPER,K,movefocus,u"
        "SUPER,L,movefocus,r"

        "SUPERSHIFT,H,movewindow,l"
        "SUPERSHIFT,J,movewindow,d"
        "SUPERSHIFT,K,movewindow,u"
        "SUPERSHIFT,L,movewindow,r"
        
        "SUPER,T,togglefloating"
        "SUPER,P,pin"

        # === workspace managing ===

        # simply change
        # "SUPER, 1, workspace, 1"
        # "SUPER, 2, workspace, 2"
        # "SUPER, 3, workspace, 3"
        # "SUPER, 4, workspace, 4"
        # "SUPER, 5, workspace, 5"
        # "SUPER, 6, workspace, 6"
        # "SUPER, 7, workspace, 7"
        # "SUPER, 8, workspace, 8"

        # hyprnome workspace changing
        "SUPERCTRL, H, exec, hyprnome --previous"
        "SUPERCTRL, L, exec, hyprnome"
        "SUPERCTRLSHIFT, H, exec, hyprnome --previous --move"
        "SUPERCTRLSHIFT, L, exec, hyprnome --move"

        # "SUPERCTRL, 1, movetoworkspace, 1"
        # "SUPERCTRL, 2, movetoworkspace, 2"
        # "SUPERCTRL, 3, movetoworkspace, 3"
        # "SUPERCTRL, 4, movetoworkspace, 4"
        # "SUPERCTRL, 5, movetoworkspace, 5"
        # "SUPERCTRL, 6, movetoworkspace, 6"
        # "SUPERCTRL, 7, movetoworkspace, 7"
        # "SUPERCTRL, 8, movetoworkspace, 8"

        # === basic utils ===
        
        # clipboard manager
        "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        
        # brightness
        ", xf86monbrightnessup, exec, brightnessctl set 10%+"
        ", xf86monbrightnessdown, exec, brightnessctl set 10%-"

        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # screen shot
        ", PRINT, exec, hyprshot -m region" # a region
        "SUPER, PRINT, exec, hyprshot -m window" # a window
        "SUPERCTRL, PRINT, exec, hyprshot -m output" # monitor
      ];

      bindm = [
        "SUPER, mouse:272, movewindow" # 左键
        "SUPER, mouse:273, resizewindow" # 右键
      ];
      
      exec-once = [
        "dbus-update-activation-environment --systemd DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_SESSION_DESKTOP=Hyprland XDG_CURRENT_DESKTOP=Hyprland XDG_SESSION_TYPE=wayland"
        "dunst"
        "fcitx5"
        "hyprpaper"
        "hypridle"
        # "waybar"
        # "emacs --daemon"
        ("hyprctl dispatch workspace " + toString start_workspace)
      ];
    };
  };

}
