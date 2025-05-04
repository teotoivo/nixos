
{ config, pkgs, ... }:

{
	time.timeZone = "Europe/Helsinki";
	i18n.defaultLocale = "en_US.UTF-8";

  	console.keyMap      = "fi";
	services.xserver.layout = "fi";

	security.sudo.wheelNeedsPassword = true;
	security.auditd.enable = true;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	system.stateVersion = "24.05";

	users.users.teotoivo = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	nixpkgs.config.allowUnfree = true;

	networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [
		htop
		vim
		git
	];
}

