
{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;

		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "sudo" "fzf" ];
			theme = "agnoster";
		};

		shellAliases = {
			ll = "ls -lah";
			gs = "git status -sb";
		};
	};
}

