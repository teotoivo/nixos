{ config, pkgs, ... }:

let
	hypridle_config = ''
		general {
			lock_cmd = pidof hyprlock || hyprlock
			before_sleep_cmd = loginctl lock-session
			after_sleep_cmd = hyprctl dispatch dpms on
		}

		listener {
			timeout = 450
			on-timeout = brightnessctl -s set 10
			on-resume = brightnessctl -r
		}

		listener {
			timeout = 450
			on-timeout = brightnessctl -sd rgb:kbd_backlight set 0
			on-resume = brightnessctl -rd rgb:kbd_backlight
		}

		listener {
			timeout = 600
			on-timeout = loginctl lock-session
		}

		listener {
			timeout = 660
			on-timeout = hyprctl dispatch dpms off
			on-resume = hyprctl dispatch dpms on
		}

		listener {
			timeout = 1800
			on-timeout = systemctl suspend
		}
	'';
in
{
	programs.hypridle.enable = true;

	# Declaratively provide config
	xdg.configFile."hypr/hypridle.conf".text = hypridle_config;

	# Optional: Ensure required packages
	home.packages = with pkgs; [
		hypridle
		hyprlock
		brightnessctl
	];
}

