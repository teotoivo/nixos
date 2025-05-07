
{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		../../modules/login.nix
    ../../modules/shells.nix
		];

	services.xserver.videoDrivers = [ "modesetting" ];
	environment.sessionVariables.HYPR_SCALE = "1.25";

  services.tlp.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";
}

