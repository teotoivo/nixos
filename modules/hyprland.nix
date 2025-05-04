
{ pkgs, ... }:

{
	programs.hyprland.enable = true;
	programs.hyprland.package = pkgs.hyprland;

	services.dbus.packages = [ pkgs.xdg-desktop-portal-hyprland ];
	
	environment.systemPackages = with pkgs; [
		# ── Terminals / launchers ────────────────────────────────
    ghostty                   # $terminal
    wofi                      # $menu

    # ── Core Hyprland companions ─────────────────────────────
    hyprshot                  # screenshots
    hyprlock                  # lock‑screen
    hypridle                  # idle daemon
    hyprpaper                 # wallpaper daemon
    waybar                    # panel / status bar
    swaynotificationcenter    # “swaync” – notification daemon

    # ── Desktop & file management ────────────────────────────
    nautilus                  # $fileManager
    nwg-look                  # GTK theme tweak tool

    # ── Media, volume & brightness helpers ───────────────────
    playerctl                 # MPRIS media keys
    brightnessctl             # backlight control
    (pipewirePackages.wpctl)  # volume control (`wpctl`) from PipeWire

    # ── NVIDIA PRIME helper (for `sudo prime-offload`) ───────
    nvidia-prime

    # ── Optional (commented‑out line in your Hypr cfg) ───────
    networkmanagerapplet      # nm-applet tray icon
	];
}

