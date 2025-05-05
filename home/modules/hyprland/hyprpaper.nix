{ config, pkgs, lib, ... }:

let
	hyprpaper_conf = ''
		preload = ~/backgrounds/atlantis.jpg
		wallpaper = , ~/backgrounds/atlantis.jpg
	'';
in
{
	home.packages = with pkgs; [
		hyprpaper
		curl
	];

	xdg.configFile."hypr/hyprpaper.conf".text = hyprpaper_conf;

	# Download wallpaper on activation
	home.activation.download_wallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
		mkdir -p ~/backgrounds
		${pkgs.curl}/bin/curl --fail --silent --show-error --location --output ~/backgrounds/atlantis.jpg \
			https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/atlantis.jpg
	'';

	# Autostart hyprpaper via user service
	systemd.user.services.hyprpaper = {
		Unit = {
			Description = "Hyprpaper wallpaper daemon";
			After = [ "graphical-session.target" ];
		};
		Service = {
			ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
			Restart = "always";
		};
		Install = {
			WantedBy = [ "graphical-session.target" ];
		};
	};
}

