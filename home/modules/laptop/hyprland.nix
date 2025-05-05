{ pkgs, ... }:

###############################################################################
#  THEMING (cursor, GTK) — these are top‑level Home‑Manager options
###############################################################################

{
  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    package    = pkgs.bibata-cursors;
    name       = "Bibata-Modern-Classic";
    size       = 16;
  };

  # GTK look‑and‑feel
  gtk = {
    enable = true;
    theme.package     = pkgs.flat-remix-gtk;
    theme.name        = "Flat-Remix-GTK-Grey-Darkest";

    iconTheme.package = pkgs.gnome.adwaita-icon-theme;
    iconTheme.name    = "Adwaita";

    font = { name = "Sans"; size = 11; };
  };

###############################################################################
#  HYPRLAND — Home‑Manager module
###############################################################################

  wayland.windowManager.hyprland = {
    enable = true;

    # Export full env to user‑services (fixes PATH for hypridle, etc.)
    systemd.variables = [ "--all" ];

    settings = {

      #########################
      ##  ENVIRONMENT VARS  ##
      #########################
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Nordzy-hyprcursors-catppuccin-mocha-maroon"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Nordzy-hyprcursors-catppuccin-mocha-maroon"
      ];

      ################
      ##  MONITORS  ##
      ################
      monitor = [
        "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27Q X 23320B006060, 2560x1440@144, 0x0, 1, workspace, 1"
        "desc:Samsung Electric Company Odyssey G52A H4ZRC00753, 2560x1440@144, 2560x-1120, 1, transform, 1, workspace, 1"
        "eDP-1, 2560x1600@240, 0x0, 1.25"
      ];

      ################
      ##  AUTOSTART ##
      ################
      "exec-once" = [
       "waybar"
  	"swaync"
  	"hypridle"
  	"hyprpaper"
        "hyprctl dispatch workspace 1"
        "nwg-look -a"
      ];

      #########
      ## WM  ##
      #########
      general = {
        gaps_in            = 3;
        gaps_out           = 10;
        border_size        = 1;
        "col.active_border"  = "rgba(89B4FAee) rgba(CBA6F7ee) 45deg";
        "col.inactive_border" = "rgba(313244aa)";
        resize_on_border   = false;
        allow_tearing      = false;
        layout             = "dwindle";
      };

      cursor.no_hardware_cursors = true;

      decoration = {
        rounding       = 10;
        active_opacity   = 1.0;
        inactive_opacity = 1.0;

        # new shadow keys (Hyprland ≥ 0.46)
        drop_shadow         = true;
        shadow_range        = 4;
        shadow_render_power = 3;
        shadow_offset       = "0 0";

        blur = {
          enabled  = true;
          size     = 7;
          passes   = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";
        bezier  = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global,     1, 10, default"
          "border,     1,  5, easeOutQuint"
          "windows,    1,  4, easeOutQuint"
          "windowsIn,  1,  4, easeOutQuint, popin 87%"
          "windowsOut, 1,  2, linear,       popin 87%"
          "fadeIn,     1,  2, linear"
          "fadeOut,    1,  2, linear"
          "workspaces, 1,  2, linear,       fade"
        ];
      };

      dwindle = {
        pseudotile     = true;
        preserve_split = true;
      };

      master.new_status      = "master";
      misc.force_default_wallpaper = 0;

      ##########
      ## INPUT##
      ##########
      input = {
        kb_layout     = "fi";
        follow_mouse  = 1;
        sensitivity   = 0;
        touchpad.natural_scroll = true;
      };
      gestures.workspace_swipe = false;

      ################
      ## KEY BINDS  ##
      ################
      "$mainMod" = "SUPER";

      # workspace {1..10} and move‑to counterparts
      bind = [

	
	# workspace binds 1–10
	"$mainMod, 1, workspace, 1"
	"$mainMod SHIFT, 1, movetoworkspace, 1"
	"$mainMod, 2, workspace, 2"
	"$mainMod SHIFT, 2, movetoworkspace, 2"
	"$mainMod, 3, workspace, 3"
	"$mainMod SHIFT, 3, movetoworkspace, 3"
	"$mainMod, 4, workspace, 4"
	"$mainMod SHIFT, 4, movetoworkspace, 4"
	"$mainMod, 5, workspace, 5"
	"$mainMod SHIFT, 5, movetoworkspace, 5"
	"$mainMod, 6, workspace, 6"
	"$mainMod SHIFT, 6, movetoworkspace, 6"
	"$mainMod, 7, workspace, 7"
	"$mainMod SHIFT, 7, movetoworkspace, 7"
	"$mainMod, 8, workspace, 8"
	"$mainMod SHIFT, 8, movetoworkspace, 8"
	"$mainMod, 9, workspace, 9"
	"$mainMod SHIFT, 9, movetoworkspace, 9"
	"$mainMod, 0, workspace, 10"
	"$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, Q, exec, ghostty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, space, exec, wofi --show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, F, fullscreen"

        # screenshots
        ", PRINT, exec, hyprshot -m window"
        "SHIFT, PRINT, exec, hyprshot -m region"

        # lock
        "$mainMod ALT, L, exec, hyprlock"

        # focus
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # move window
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # scroll through workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # mouse / resize
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # volume / brightness / media keys
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      #################
      ## WINDOW RULE ##
      #################
      windowrule  = [ "opacity 0.92 0.92, title:.*[Ff]irefox.*" ];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      xwayland.force_zero_scaling = true;
    };
  };
}

