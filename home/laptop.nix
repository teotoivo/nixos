
{ ... }:

{
	imports = [ ./common.nix ./modules/hyprland.nix ];

	wayland.windowManager.hyprland.settings = {
		monitor = [ "eDP-1,preferred,0x0,1.25" ];
		"input:touchpad:tap-to-click" = "true";
	};
}

