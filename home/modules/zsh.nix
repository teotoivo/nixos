{ config, pkgs, ... }:

{
	# Install required packages
	home.packages = [
		pkgs.zsh-powerlevel10k
		pkgs.fzf
	];

	home.file.".p10k.zsh".source = ./p10k.zsh;

	# Symlink powerlevel10k where oh-my-zsh expects it
	home.file.".oh-my-zsh/custom/themes/powerlevel10k".source =
		"${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;

		oh-my-zsh = {
			enable = true;
			theme = "powerlevel10k/powerlevel10k";
			plugins = [
				"git"
				"fzf"
				"z"
				"colored-man-pages"
			];
		};

		# Prevent sourcing global zshrc (reproducibility)
		initExtraBeforeCompInit = ''
			unsetopt GLOBAL_RCS
			export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom/"
		'';

		# Environment and plugin bootstrapping
		initExtra = ''
    # fzf plugin requires this
	export FZF_BASE="${pkgs.fzf}/share/fzf"
	[ -f "$FZF_BASE/shell/key-bindings.zsh" ] && source "$FZF_BASE/shell/key-bindings.zsh"
	[ -f "$FZF_BASE/shell/completion.zsh" ] && source "$FZF_BASE/shell/completion.zsh"

	# General env
	export EDITOR=nvim
	export PATH="$HOME/.local/bin:$PATH"

	# powerlevel10k
	[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
		'';
	};



    home.file.".zshrc".text = ''
    # Enable syntax highlighting with Catppuccin colors
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  '';
}
