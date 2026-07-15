{ config, pkgs, inputs, lib, ... }:
let
  wallpaperPath =
    if builtins.hasAttr "stylix" config
    && builtins.hasAttr "image" config.stylix
    && config.stylix.image != null
    then "${config.stylix.image}"
    else toString ../../../../themes/ophelia/ophelia_new.jpg;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    gpu-screen-recorder
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      # ── Shell / Global UI ──────────────────────────────────────
      shell = {
        font_family = "Fira Code";
        ui_scale = 1.0;
        setup_wizard_enabled = false;
        corner_radius_scale = 0.7;
        animation = {
          enabled = true;
          speed = 1.0;
        };
        shadow = {
          direction = "down_right";
          alpha = 0.55;
        };
        panel = {
          control_center_placement = "floating";
          session_placement = "floating";
          session_position = "center";
        };
        # Session menu (power options)
        session.actions = [
          { action = "lock"; }
          { action = "suspend"; }
          { action = "command"; label = "Hibernate"; command = "systemctl hibernate"; }
          { action = "reboot"; }
          { action = "logout"; }
          { action = "shutdown"; }
        ];
      };

      # ── Bar ────────────────────────────────────────────────────
      bar = {
        order = [ "main" ];
        main = {
          position = "top";
          background_opacity = 0.0;
          capsule = true;
          capsule_opacity = 1.0;
          margin_edge = 0;
          margin_ends = 7;
          padding = 0;
          start = [ "control-center" "group:g1" "group:g2" "active_window" "audio_visualizer" ];
          center = [ "taskbar" ];
          end = [ "battery" "group:g4" "tray" "notifications" "group:g3" ];
          capsule_group = [
            {
              id = "g1";
              enabled = true;
              fill = "surface_variant";
              border = "";
              opacity = 1.0;
              padding = 6.0;
              members = [ "clock" "weather" ];
            }
            {
              id = "g2";
              enabled = true;
              fill = "surface_variant";
              opacity = 1.0;
              padding = 6.0;
              members = [ "cpu" "ram" "sysmon" ];
            }
            {
              id = "g3";
              enabled = true;
              fill = "surface_variant";
              opacity = 1.0;
              padding = 6.0;
              members = [ "volume" "brightness" "input_volume" ];
            }
            {
              id = "g4";
              enabled = true;
              fill = "surface_variant";
              opacity = 1.0;
              padding = 6.0;
              members = [ "network" "bluetooth" ];
            }
          ];
        };
      };

      # ── Widget configurations ──────────────────────────────────
      widget = {
        sysmon.stat = "disk_pct";
        ram.stat = "ram_pct";
        weather.show_condition = false;
        clock.format = "{:%m-%d %a %H:%M}";
        taskbar = {
          group_by_workspace = true;
          group_single_icon_per_app = true;
          hide_empty_workspaces = true;
          show_workspace_label = false;
          active_opacity = 0.99;
          inactive_opacity = 0.67;
        };
        control-center.glyph = "skull";
        battery = {
          display_mode = "graphic";
          scale = 0.85;
        };
        cat.type = "noctalia/bongocat:cat";
        cat_2.type = "noctalia/bongocat:cat";
        tray = {
          hidden = [ "nm-applet" "bluetooth" ];
          drawer = false;
        };
      };

      # ── Keybinds ──────────────────────────────────────────────
      keybinds = {
        up = [ "Ctrl+k" ];
        down = [ "Ctrl+j" ];
        left = [ "Ctrl+h" ];
        right = [ "Ctrl+l" ];
      };

      # ── Plugins ───────────────────────────────────────────────
      plugins.enabled = [ "noctalia/bongocat" ];

      # ── Theme ──────────────────────────────────────────────────
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Kanagawa";
      };

      # ── Wallpaper ──────────────────────────────────────────────
      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        transition_duration = 1500;
        default.path = wallpaperPath;
      };

      # ── Location & Weather ─────────────────────────────────────
      location.address = "Shanghai";
      weather.enabled = true;

      # ── Audio ──────────────────────────────────────────────────
      audio.enable_overdrive = false;

      # ── Notifications ──────────────────────────────────────────
      notification = {
        enable_daemon = true;
        position = "top_right";
      };

      # ── OSD ────────────────────────────────────────────────────
      osd.position = "top_right";

      # ── Dock (disabled) ────────────────────────────────────────
      dock.enabled = false;

      # ── Control Center ─────────────────────────────────────────
      control_center.sidebar = "compact";
    };
  };
}
