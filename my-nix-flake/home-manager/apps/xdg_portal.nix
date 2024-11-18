{ pkgs, ...}:
{
	xdg.portal = {
		enable = false;
		extraPortals = [pkgs.xdg-desktop-portal-hyprland];
	};
}
