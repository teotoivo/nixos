{ config, pkgs, ... }:

let
	# You can refactor this into a separate file if preferred
	hyprlock_conf = ''
		source = $HOME/.config/hypr/mocha.conf

		$accent = $mauve
		$accentAlpha = $mauveAlpha
		$font = JetBrainsMono Nerd Font

		general {
			disable_loading_bar = true
			hide_cursor = true
		}

		background {
			monitor =
			path = ~/backgrounds/atlantis.jpg
			blur_passes = 2
			color = $base
		}

		label {
			monitor =
			text = cmd[update:30000] echo "$(date +"%R")"
			color = $text
			font_size = 90
			font_family = $font
			position = -30, 0
			halign = right
			valign = top
		}

		label {
			monitor =
			text = cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"
			color = $text
			font_size = 25
			font_family = $font
			position = -30, -150
			halign = right
			valign = top
		}

		image {
			monitor =
			path = ~/.face
			size = 100
			border_color = $accent
			position = 0, 75
			halign = center
			valign = center
		}

		input-field {
			monitor =
			size = 300, 60
			outline_thickness = 4
			dots_size = 0.2
			dots_spacing = 0.2
			dots_center = true
			outer_color = $accent
			inner_color = $surface0
			font_color = $text
			fade_on_empty = false
			placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
			hide_input = false
			check_color = $accent
			fail_color = $red
			fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
			capslock_color = $yellow
			position = 0, -35
			halign = center
			valign = center
		}
	'';

	mocha_conf = ''
		$rosewater = rgb(f5e0dc)
		$rosewaterAlpha = f5e0dc
		...
		$crust = rgb(11111b)
		$crustAlpha = 11111b
	'';
in {
	programs.hyprlock.enable = true;

	xdg.configFile."hypr/hyprlock.conf".text = hyprlock_conf;
	xdg.configFile."hypr/mocha.conf".text = mocha_conf;

	home.packages = with pkgs; [
		hyprlock
		jetbrains-mono
	];
}

