{ config, lib, pkgs, inputs, ... }:

let
	neovim_unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

	neovim_wrapped = pkgs.wrapNeovimUnstable neovim_unwrapped {
		# You can extend with extra runtime dependencies here
	};

in {
	programs.neovim = {
		enable = true;
		package = neovim_wrapped;
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

