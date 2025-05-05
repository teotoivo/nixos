
{ config, pkgs, pkgsUnstable, lib, ... }:

{
	time.timeZone = "Europe/Helsinki";
	i18n.defaultLocale = "en_US.UTF-8";

  	console.keyMap      = "fi";
	services.xserver.layout = "fi";

	security.sudo.wheelNeedsPassword = true;
	security.auditd.enable = true;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	security.pam.loginLimits = [
  	{
    		domain = "@users";
   	 	type = "soft";
   	 	item = "nofile";
   	 	value = "65536";
  	}
  	{
    		domain = "@users";
    		type = "hard";
    		item = "nofile";
    		value = "65536";
  	}
	];

	system.stateVersion = "24.05";

	users.users.teotoivo = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	nixpkgs.config.allowUnfree = true;

	hardware.nvidia.open = true;

	networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [
		htop
		vim
		git
		vscode
		tree
		pkgsUnstable.firefox
	];

services.pipewire = {
		enable = true;
		audio.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true; # optional
	};


	fonts.fontconfig.enable = true;
fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
];


}
