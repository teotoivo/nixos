{ config, pkgs, lib, ... }:

{
	programs.neovim = {
		enable = true;
		package = pkgs.neovim; # this now points to the nightly version from the overlay
	};
}

