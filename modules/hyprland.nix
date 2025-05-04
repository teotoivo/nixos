
{ pkgs, ... }:

{
	programs.hyprland.enable = true;
	programs.hyprland.package = pkgs.hyprland;

	services.dbus.packages = [ pkgs.xdg-desktop-portal-hyprland ];
}

