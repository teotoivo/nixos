{ config, pkgs, ... }:

let
	catppuccin_tmux = pkgs.stdenv.mkDerivation {
		name = "catppuccin-tmux";
		src = pkgs.fetchFromGitHub {
			owner = "catppuccin";
			repo = "tmux";
			rev = "v2.1.3";
      sha256 = "sha256-Is0CQ1ZJMXIwpDjrI5MDNHJtq+R3jlNcd9NXQESUe2w=";
		};
		installPhase = ''
			mkdir -p $out/share/tmux-plugins/catppuccin
			cp -r * $out/share/tmux-plugins/catppuccin
		'';
	};
in {
	programs.tmux = {
		enable = true;

		# Avoid TPM, but still allow plugin use if needed
		plugins = with pkgs; [
			tmuxPlugins.vim-tmux-navigator
		];

		extraConfig = ''
			# Reload config manually
			unbind r
			bind r source-file ~/.tmux.conf

			# Fix Colors
			set -g default-terminal "screen-256color"
			set -as terminal-features ",xterm-256color:RGB"

			# Prefix key
			set -g prefix C-s

			# Enable mouse support
			set -g mouse on

			# Pane movement
			bind-key h select-pane -L
			bind-key j select-pane -D
			bind-key k select-pane -U
			bind-key l select-pane -R

      # Pane splitting
      bind h split-window -h
      bind v split-window -v

      # Pane cleanup
      bind x kill-pane
      bind o kill-pane -a
      bind w confirm-before -p "Kill window? (y/n)" kill-window


			# Start windows and panes at 1
			set -g base-index 1
			set-window-option -g pane-base-index 1

			# Catppuccin config
			set -g @catppuccin_flavor "mocha"
			set -g @catppuccin_window_status_style "rounded"

			run-shell "${catppuccin_tmux}/share/tmux-plugins/catppuccin/catppuccin.tmux"

			set -g status-right-length 100
			set -g status-left-length 100
			set -g status-left ""
			set -g status-right "#{E:@catppuccin_status_application}"
			set -ag status-right "#{E:@catppuccin_status_session}"

			# Smart Vim-aware pane switching
			is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
				| grep -iqE '^[^TXZ ]+ +(\\\\S+/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
			bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
			bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
			bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
			bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

			tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\\1/p")'
			if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
				"bind-key -n 'C-\\' if-shell \\"$is_vim\\" 'send-keys C-\\\\'  'select-pane -l'"
			if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
				"bind-key -n 'C-\\' if-shell \\"$is_vim\\" 'send-keys C-\\\\\\\\'  'select-pane -l'"

			bind-key -T copy-mode-vi 'C-h' select-pane -L
			bind-key -T copy-mode-vi 'C-j' select-pane -D
			bind-key -T copy-mode-vi 'C-k' select-pane -U
			bind-key -T copy-mode-vi 'C-l' select-pane -R
		'';
	};
}

