{ config, lib, pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		baseIndex = 1;
		keyMode = "vi";
		mouse = true;
		prefix = "C-s";
		terminal = "screen-256color";
		extraConfig = ''
			unbind r
			bind r source-file ~/.config/tmux/tmux.conf

			# Fix Colors
			set -as terminal-features ",xterm-256color:RGB"

			# Pane keybindings
			bind-key h select-pane -L
			bind-key j select-pane -D
			bind-key k select-pane -U
			bind-key l select-pane -R
			set -g pane-base-index 1

			# TPM & Catppuccin (loaded from config below)
			run-shell ~/.config/tmux/catppuccin.tmux

			# Status customization
			set -g status-right-length 100
			set -g status-left-length 100
			set -g status-left ""
			set -g status-right "#{E:@catppuccin_status_application}"
			set -ag status-right "#{E:@catppuccin_status_session}"

			# Smart pane switching aware of Vim splits
			is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
				| grep -iqE '^[^TXZ ]+ +(\\\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
			bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
			bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
			bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
			bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
			tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\\1/p")'
			if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
				"bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
			if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
				"bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

			bind-key -T copy-mode-vi 'C-h' select-pane -L
			bind-key -T copy-mode-vi 'C-j' select-pane -D
			bind-key -T copy-mode-vi 'C-k' select-pane -U
			bind-key -T copy-mode-vi 'C-l' select-pane -R
			bind-key -T copy-mode-vi 'C-\\' select-pane -l
		'';
	};

	# Install Catppuccin plugin (assumes manual plugin handling)
	xdg.configFile."tmux/catppuccin.tmux".source =
		pkgs.fetchFromGitHub {
			owner = "catppuccin";
			repo = "tmux";
			rev = "HEAD"; # pin to a specific commit if needed
			sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # replace with actual
		} + "/catppuccin.tmux";

	# Plugin config (nonstandard @variables must go in a separate file or inline in `extraConfig`)
	xdg.configFile."tmux/tmux.conf".text = ''
		set -g @catppuccin_flavor "mocha"
		set -g @catppuccin_window_status_style "rounded"
	'';
}

