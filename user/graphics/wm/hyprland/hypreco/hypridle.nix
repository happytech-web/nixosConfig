{ pkgs, ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "bash -lc '[ ! -f ~/.config/hypr/.nosleep ] && brightnessctl -s set 10'";
          on-resume  = "brightnessctl -r";
        }
        {
          # 5 min: 键盘背光
          timeout = 300;
          on-timeout = "bash -lc '[ ! -f ~/.config/hypr/.nosleep ] && brightnessctl -sd rgb:kbd_backlight set 0'";
          on-resume  = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          # 6.5 min: 锁屏
          timeout = 390;
          on-timeout = "bash -lc '[ ! -f ~/.config/hypr/.nosleep ] && loginctl lock-session'";
        }
        {
          # 7 min: 熄屏
          timeout = 420;
          on-timeout = "bash -lc '[ ! -f ~/.config/hypr/.nosleep ] && hyprctl dispatch dpms off'";
          on-resume  = "bash -lc 'hyprctl dispatch dpms on && brightnessctl -r'";
        }
        {
          # 30 min: 挂起
          timeout = 1800;
          on-timeout = "bash -lc '[ ! -f ~/.config/hypr/.nosleep ] && systemctl suspend'";
        }
      ];
    };
  };
}

