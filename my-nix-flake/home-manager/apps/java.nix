{ pkgs , ... }:
{

	programs.java = {
		enable = true;
		package = pkgs.jre_minimal;
	};

}
