{ pkgs, ...}: 
{
	services.mako = {
		enable = true;
		anchor = "top-right";
		actions = true;
      		borderRadius = 8;
      		borderSize = 1;
      		defaultTimeout = 10000;
      		font = "Inter";
      		iconPath = let
			name = "Papirus-Dark";
    			package = pkgs.papirus-icon-theme;
			in
			"${package}/share/icons/${name}";
      		icons = true;
      		layer = "overlay";
      		maxVisible = 3;
      		padding = "10";
      		width = 300;
	};
}
