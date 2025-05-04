
{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		../../modules/login.nix
		];

	services.xserver.videoDrivers = [ "nvidia" ];
	environment.sessionVariables.HYPR_SCALE = "1.25";
}

