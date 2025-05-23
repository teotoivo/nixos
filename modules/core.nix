
{ config, pkgs, pkgsUnstable, lib, ... }:

{
	time.timeZone = "Europe/Helsinki";
	i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
      EDITOR = "nvim";
    };
	
  	console.keyMap      = "fi";
	services.xserver.layout = "fi";

	security.sudo.wheelNeedsPassword = true;
	security.auditd.enable = true;

boot.loader.systemd-boot.enable = false;
boot.loader.efi.canTouchEfiVariables = true;
boot.loader.grub.enable = true;
boot.loader.grub.devices = [ "nodev" ];
boot.loader.grub.efiSupport = true;
boot.loader.grub.useOSProber = true;

boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  pname = "distro-grub-themes";
  version = "3.1";
  src = pkgs.fetchFromGitHub {
    owner = "AdisonCavani";
    repo = "distro-grub-themes";
    rev = "v3.1";
    hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
  };
  installPhase = "cp -r customize/nixos $out";
};


services = {
    logind = {
        lidSwitch = "poweroff";
        lidSwitchDocked = "poweroff";
    };
  };

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



	system.stateVersion = "24.11";

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	users.users.teotoivo = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
	};

	nixpkgs.config.allowUnfree = true;

	hardware.nvidia.open = true;

	networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [
		home-manager
		htop
		vim
		git
		vscode
		tree
		pkgsUnstable.firefox
		curl
    fzf
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

# Correctly set environment variables and paths
environment.variables.PATH = lib.mkForce "${pkgs.brightnessctl}/bin:${pkgs.hyprland}/bin:${pkgs.systemd}/bin:/home/teotoivo/.nix-profile/bin";

imports = [
	./neovim.nix
  #./firefox.nix
];

}
