
{ config, pkgs, ... }:

{
	home.stateVersion = "24.05";
	home.username = "teotoivo";
	home.homeDirectory = "/home/teotoivo";

	imports = [
		./modules/zsh.nix
		./modules/git.nix
		./modules/waybar.nix
		./modules/wofi.nix
		./modules/tmux.nix
		./modules/yazi.nix
		./modules/ghostty.nix
	];
}

