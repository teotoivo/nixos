
{ config, lib, ... }:

{
	wayland.windowManager.hyprland.enable = true;
	
	imports = [
		./hyprland/hyprpaper.nix
		./hyprland/hypridle.nix
		./hyprland/hyprlock.nix
	];
}

