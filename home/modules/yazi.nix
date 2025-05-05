{ config, pkgs, ... }:

{
	home.packages = [ pkgs.yazi ];

	xdg.configFile."yazi/yazi.toml".text = ''
		[manager]
		show_hidden = true
	'';
}

