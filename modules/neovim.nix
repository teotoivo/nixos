{ config, lib, pkgs, inputs, ... }:

let
	# Patch meta for the nightly overlay package
	neovim_nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default.overrideAttrs (old: {
		meta = old.meta or { } // {
			maintainers = [ ];
		};
	});
in {
	programs.neovim = {
		enable = true;
		package = neovim_nightly;
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

