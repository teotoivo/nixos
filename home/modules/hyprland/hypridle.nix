{ config, pkgs, ... }:

let
  # General Hyprland idle configuration
  hypridle_conf = ''
    general {
      lock_cmd = "pidof hyprlock || hyprlock";  # Prevent multiple hyprlock instances
      before_sleep_cmd = "loginctl lock-session";  # Lock before suspend
      after_sleep_cmd = "hyprctl dispatch dpms on";  # Turn on the display after resuming from sleep
    }

    listener {
      timeout = 450;  # 2.5min
      on-timeout = "brightnessctl -s set 10";  # Set monitor backlight to minimum
      on-resume = "brightnessctl -r";  # Restore monitor backlight
    }

    # Keyboard backlight control
    listener {
      timeout = 450;  # 2.5min
      on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";  # Turn off keyboard backlight
      on-resume = "brightnessctl -rd rgb:kbd_backlight";  # Restore keyboard backlight
    }

    listener {
      timeout = 600;  # 5min
      on-timeout = "loginctl lock-session";  # Lock screen after timeout
    }

    listener {
      timeout = 660;  # 5.5min
      on-timeout = "hyprctl dispatch dpms off";  # Turn off screen after timeout
      on-resume = "hyprctl dispatch dpms on";  # Turn on screen after resuming from timeout
    }

    listener {
      timeout = 1800;  # 30min
      on-timeout = "systemctl suspend";  # Suspend system after inactivity
    }
  '';

in {


  xdg.configFile."hypr/hyprlock.conf".text = hypridle_conf;

  home.packages = with pkgs; [
    hypridle
    brightnessctl
  ];
}

