{ pkgs, config, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      reload_style_on_change = true;
      modules-left = [
        "custom/logo"
        "clock"
        "battery"
      ];
       modules-center = [
        "hyprland/workspaces"
       ];
       modules-right = [
      #   "pulseaudio"
      #   "backlight"
      #   "cpu"
      #   "memory"
      #   "disk"
      #   "network"
      #   "battery"
      #   "custom/powermenu"
         "group/hardware"
         "tray"
      ];

      "custom/logo" = {
        format = " ";
      };

      clock = {
        format = "{:%H:%M %a}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };

      battery = {
        
        states = {
            "warning" = 30;
            "critical" = 15;
        };

        format = "{icon}   {capacity}%";
        format-charging = "󰂄  {capacity}%";
        format-plugged = "  {capacity}%";
        format-alt = "{icon}  {time}";
        format-icons = [" " " " " " " " " "];
      };

      "group/hardware" = {
        orientation = "horizontal";
        modules = [
          "cpu"
          "memory"
          "disk"
        ];
      };

      cpu = {
        interval = 5;
        format = "{usage}%  ";
      };

      memory = {
        interval = 5;
        format = "{percentage}%  ";
      };

      disk = {
        interval = 30;
        format = "{percentage_used}%  ";
        path = "/";
      };

      tray = {
        icon-size = 21;
        spacing = 10;
      };




      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        format = "";
        format-icons = {
            urgent = "";
            active = "";
            default = "";
        };

      };
    }];

    style = ''
      * {
        font-family: "FiraCode Nerd Font", "LXGW WenKai";
        font-size: 18px;
        border: none;
        border-radius: 0px;     
      }

      window#waybar {
        background: rgba(0,0,0,0.2);
        border-bottom: 0px solid #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
        margin: 0;
        padding: 0;
      }

      /* Waybar 工作区整体背景 */
      #workspaces {
        background: #${colors.base00}; /* 使用 Base16 颜色 */
        margin: 5px 1px 6px 1px;
        padding: 0px 1px;
        border-radius: 15px;
        border: 0px;
        font-weight: bold;
        font-style: normal;
        opacity: 0.8;
        font-size: 16px;
        color: #${colors.base05}; /* 文字颜色 */
      }

      /* 非活动工作区按钮 */
      #workspaces button {
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px; /* 统一圆角 */
        border: 0px;
        color: #${colors.base05}; /* 文字颜色 */
        background-color: #${colors.base01}; /* 使用 Base16 的次背景色 */
        transition: all 0.3s ease-in-out;
        opacity: 0.4; /* 透明度较低 */
      }

      /* 活动工作区按钮（高亮） */
      #workspaces button.active {
        color: #${colors.base06}; /* 文字颜色 */
        background: #${colors.base0D}; /* 使用 Base16 高亮色 */
        border-radius: 20px; /* 让活动窗口变成长方圆形 */
        min-width: 40px;
        transition: all 0.3s ease-in-out;
        opacity: 1.0; /* 透明度100% */
      }

      /* 鼠标悬停时的按钮效果 */
      #workspaces button:hover {
        color: #${colors.base06}; /* 文字颜色 */
        background: #${colors.base02}; /* 轻微高亮 */
        border-radius: 15px;
        opacity: 0.7;
      }

      /* 紧急状态（警告窗口） */
      #workspaces button.urgent {
        background: #${colors.base08}; /* 警告时使用 Base16 的红色 */
        color: white;
        border-radius: 15px;
      }


      #custom-logo,
      #disk, #memory, #cpu,
      #battery,
      #clock {
        background-color: #${colors.base00};  /* 使用 Base16 的背景色 */
        font-size: 16px;  /* 保持字体大小一致 */
        color: #${colors.base05};  /* 文字颜色 */
        border-radius: 15px;  /* 保持圆角 */
        padding: 2px 10px;  /* 上下 padding 稍微增加一点 */
        margin: 5px 10px 5px 0px;  /* 边距调整：上、右、下、左 */
        opacity: 0.8;  /* 保持透明度 */
        border: 3px solid #${colors.base01};  /* 使用 Base16 次背景色作为边框颜色 */
      }


      #tray {
        padding: 0px 15px 0px 0px;  /* 右侧留出一些间距 */
        color: #${colors.base05};  /* 文字颜色，使用 Base16 颜色方案 */
      }

      /* 非活动状态的托盘图标 */
      #tray > .passive {
        opacity: 0.6;  /* 让未激活的图标稍微变暗 */
      }

      /* 需要注意的通知图标 */
      #tray > .needs-attention {
        color: #${colors.base08};  /* 高亮警告颜色（通常是红色） */
        animation: blink 1s infinite alternate; /* 添加闪烁效果 */
      }

      /* 闪烁动画 */
      @keyframes blink {
        from {
          opacity: 1;
        }
        to {
          opacity: 0.5;
        }
      }

    '';

  };

}
