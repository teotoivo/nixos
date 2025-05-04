
{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		../../modules/login.nix
		];

	services.xserver.videoDrivers = [ "modesetting" ];
	environment.sessionVariables.HYPR_SCALE = "1.25";
}

