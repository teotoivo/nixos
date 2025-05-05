{ config, lib, pkgs, inputs, ... }:

let
in {
	programs.neovim = {
		enable = true;
		package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
		viAlias = true;
		vimAlias = true;
	};

	environment.systemPackages = with pkgs; [
		ripgrep
		fd
		tree-sitter
		lua-language-server
		nodejs
		git
		nil
	];
}

