
{ pkgs, pkgsUnstable, lib, config, ... }:

{
	programs.hyprland.enable = true;
	programs.hyprland.package = pkgsUnstable.hyprland;

	services.dbus.packages = [ pkgsUnstable.xdg-desktop-portal-hyprland ];
	
	environment.systemPackages = with pkgsUnstable; [

	pkgsUnstable.ghostty
    # ── Core Hyprland companions ─────────────────────────────
    hyprshot                  # screenshots
    hyprlock                  # lock‑screen
    pkgsUnstable.hypridle                  # idle daemon
    hyprpaper                 # wallpaper daemon
    waybar                    # panel / status bar
    swaynotificationcenter    # “swaync” – notification daemon

    # ── Desktop & file management ────────────────────────────
    nautilus                  # $fileManager
    nwg-look                  # GTK theme tweak tool

    # ── Media, volume & brightness helpers ───────────────────
    playerctl                 # MPRIS media keys
    brightnessctl             # backlight control

    # ── Optional (commented‑out line in your Hypr cfg) ───────
    networkmanagerapplet      # nm-applet tray icon

    wl-clipboard
	];
}

