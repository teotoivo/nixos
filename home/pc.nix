
{ ... }:

{
	imports = [ ./common.nix ./modules/hyprland.nix ];

	wayland.windowManager.hyprland.settings = {
		monitor = [
			"HDMI-A-1,1920x1080@144,0x0,1"
			"DP-1,2560x1440@165,1920x0,1"
		];
		bind = [
			"SUPER_SHIFT,Q,exec,firefox"
			"SUPER,RETURN,exec,alacritty"
		];
	};
}

