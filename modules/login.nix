{ pkgs, ... }:

{
	services.greetd = {
		enable = true;
		vt = 1;

		settings.default_session = {
			command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${pkgs.hyprland}/bin/Hyprland --user-menu --time --remember --asterisks";
			user = "greeter";
		};
	};

	services.xserver.enable = false;
}

