{ config, pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
		autosuggestion = {
			enable = true;
		};
		syntaxHighlighting = {
			enable = true;
		};

		ohMyZsh = {
			enable = true;
			theme = "powerlevel10k/powerlevel10k";
			plugins = [
				"git"
				"z"
				"fzf"
				"colored-man-pages"
			];
			customPkgs = with pkgs; [
				powerlevel10k
			];
		};

		# Optional: force Home Manager to fully manage ~/.zshrc
		initExtraBeforeCompInit = ''
			# Disable global zshrc sourcing for isolation
			unsetopt GLOBAL_RCS
		'';

		# Additional customizations (safe defaults)
		initExtra = ''
			export EDITOR=nvim
		'';
	};
}

