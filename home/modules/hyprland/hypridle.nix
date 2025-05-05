{ config, lib, pkgs, ... }:

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
	options.programs.hypridle.enable = lib.mkOption {
		type = lib.types.bool;
		default = false;
		description = "Enable hypridle daemon";
	};

	config = lib.mkIf config.programs.hypridle.enable {
		home.packages = with pkgs; [
			hypridle
			hyprlock
			brightnessctl
		];

		xdg.configFile."hypr/hypridle.conf".text = hypridle_config;

		systemd.user.services.hypridle = {
			Unit = {
				Description = "Hypridle daemon";
				After = [ "graphical-session.target" ];
			};
			Service = {
				ExecStart = "${pkgs.hypridle}/bin/hypridle";
				Restart = "always";
			};
			Install = {
				WantedBy = [ "graphical-session.target" ];
			};
		};
	};
}

