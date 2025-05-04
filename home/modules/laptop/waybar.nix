{ config, pkgs, ... }:

{
  #####################################################################
  # Waybar – bar shown at the top of your Hyprland session
  #####################################################################
  programs.waybar = {
    enable = true;

    # The “mainBar” key becomes the name of the bar (Waybar supports many
    # bars, but you only need one).  Everything inside is a 1‑:‑1 mapping
    # of your JSON.
    settings.mainBar = {
      position       = "top";
      "modules-left" = [ "hyprland/workspaces" ];
      "modules-center" = [ "hyprland/window" ];
      "modules-right"  = [ "network" "pulseaudio" "battery" "clock" "custom/power" ];

      # --- clock -----------------------------------------------------
      clock = {
        format          = "<span foreground='#f5c2e7'>   </span>{:%a %d %H:%M}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      # --- battery ---------------------------------------------------
      battery = {
        states = {
          warning  = 30;
          critical = 15;
        };
        format            = "<span size='13000' foreground='#a6e3a1'>{icon} </span> {capacity}%";
        "format-warning"  = "<span size='13000' foreground='#B1E3AD'>{icon} </span> {capacity}%";
        "format-critical" = "<span size='13000' foreground='#E38C8F'>{icon} </span> {capacity}%";
        "format-charging" = "<span size='13000' foreground='#B1E3AD'> </span>{capacity}%";
        "format-plugged"  = "<span size='13000' foreground='#B1E3AD'> </span>{capacity}%";
        "format-alt"      = "<span size='13000' foreground='#B1E3AD'>{icon} </span> {time}";
        "format-full"     = "<span size='13000' foreground='#B1E3AD'> </span>{capacity}%";
        "format-icons"    = [ "" "" "" "" "" ];
        "tooltip-format"  = "{time}";
      };

      # --- network ---------------------------------------------------
      network = {
        "format-wifi"        = "<span size='13000' foreground='#f5e0dc'>  </span>{essid}";
        "format-ethernet"    = "<span size='13000' foreground='#f5e0dc'>󰤭  </span> Connected";
        "format-linked"      = "{ifname} (No IP) ";
        "format-disconnected" = "<span size='13000' foreground='#f5e0dc'>  </span>Disconnected";
        "tooltip-format-wifi" = "Signal Strenght: {signalStrength}%";
        "on-click"            = "nm-connection-editor";
      };

      # --- pulseaudio -----------------------------------------------
      pulseaudio = {
        format          = "{icon}  {volume}%";
        "format-muted"  = "";
        "format-icons"  = { default = [ "" "" " " ]; };
        "on-click"      = "pavucontrol";
      };

      # --- power button (custom module) ------------------------------
      "custom/power" = {
        format   = "<span size='13000' foreground='#f5e0dc'>  </span>";
        "on-click" = "${config.home.homeDirectory}/.config/waybar/power-menu.sh";
      };
    };
  };

  #####################################################################
  # Ensure all commands Waybar calls are on the system PATH
  #####################################################################
  environment.systemPackages = with pkgs; [
    # -- Waybar itself (already brought in by programs.waybar, but
    #    having it here doesn’t hurt if you prefer all tools listed) --
    waybar pavucontrol networkmanagerapplet nm-connection-editor
  ];
}

