{ pkgs, ... }:

{
	services.greetd = {
		enable = true;
		vt = 1;
		settings.default_session = {
				command = "${pkgs.hyprland}/bin/Hyprland";
				user = "teotoivo";
			};
	};
	services.xserver.enable = false;
}
