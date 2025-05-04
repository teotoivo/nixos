{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable   = true;
    xwayland.enable = true;

    settings = {

      #############
      ### ENV ###
      #############
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
        "LIBVA_DRIVER_NAME,mesa"
        "GBM_BACKEND,mesa"
        "__GLX_VENDOR_LIBRARY_NAME,mesa"
        "WLR_DRM_DEVICES,/dev/dri/card0"
      ];

      #####################
      ### AUTOSTART ###
      #####################
      exec-once = [
        "sudo prime-offload"
        "waybar & swaync & hypridle & hyprpaper"
        "hyprctl dispatch workspace 1"
        "nwg-look -a"
      ];

      ################
      ### MONITORS ###
      ################
      monitor = [
        "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27Q X 23320B006060, 2560x1440@144, 0x0, 1, workspace, 1"
        "desc:Samsung Electric Company Odyssey G52A H4ZRC00753, 2560x1440@144, 2560x-1120, 1, transform, 1, workspace, 1"
        "eDP-1, 2560x1600@240, 0x0, 1.25"
      ];

      ###################
      ### APP ALIASES ###
      ###################
      "$terminal"     = "ghostty";
      "$fileManager"  = "nautilus";
      "$menu"         = "wofi --show drun";

      windowrule = [
        "opacity 0.92 0.92, title:.*[Ff]irefox.*"
      ];

      #####################
      ### LOOK & FEEL  ###
      #####################
      general = {
        gaps_in         = 3;
        gaps_out        = 10;
        border_size     = 1;
        col = {
          active_border   = "rgba(89B4FAee) rgba(CBA6F7ee) 45deg";
          inactive_border = "rgba(313244aa)";
        };
        resize_on_border = false;
        allow_tearing    = false;
        layout           = "dwindle";
      };

      cursor = { no_hardware_cursors = true; };

      decoration = {
        rounding         = 10;
        rounding_power   = 2;
        active_opacity   = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled      = true;
          range        = 4;
          render_power = 3;
          color        = "rgba(1a1a1aee)";
        };
        blur = {
          enabled   = true;
          size      = 7;
          passes    = 1;
          vibrancy  = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";      # fun easter‑egg kept verbatim
        bezier  = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle.pseudotile     = true;
      dwindle.preserve_split = true;

      master.new_status = "master";

      misc.force_default_wallpaper = 0;

      ##############
      ### INPUT  ###
      ##############
      input = {
        kb_layout   = "fi";
        follow_mouse = 1;
        sensitivity  = 0;
        touchpad.natural_scroll = true;
      };

      gestures.workspace_swipe = false;

      device = {
        name        = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      ###################
      ### KEYBINDINGS ###
      ###################
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, space, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, F, fullscreen"

        # Screenshots
        ",PRINT, exec, hyprshot -m window"
        "SHIFT,PRINT, exec, hyprshot -m region"

        # Lockscreen
        "$mainMod ALT, L, exec, hyprlock"

        # Focus movement
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Window movement
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Workspaces 1‑10
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scratchpad
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Move / resize with mouse
        "bindm = $mainMod, mouse:272, movewindow"
        "bindm = $mainMod, mouse:273, resizewindow"
      ];

      # 'bindel' and 'bindl' use aliases not yet parsed by Hyprland,
      # so keep them verbatim as in the original file:
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      ##############################
      ### WINDOW / WS RULES ###
      ##############################
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      xwayland.force_zero_scaling = true;
    };
  };

}

