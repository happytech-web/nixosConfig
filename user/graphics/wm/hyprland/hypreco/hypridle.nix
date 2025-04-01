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
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          # 5min.
          timeout = 300;
          # turn off keyboard backlight.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          # turn on keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          # 6.5min
          timeout = 390;
          on-timeout = "loginctl lock-session";
          # lock screen when timeout has passed
        }
        {
          # 7min
          timeout = 420;
          # screen off when timeout has passed
          on-timeout = "hyprctl dispatch dpms off";
          # screen on when activity is detected after timeout has fired.
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          # 30min
          timeout = 1800;
          # suspend pc
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
