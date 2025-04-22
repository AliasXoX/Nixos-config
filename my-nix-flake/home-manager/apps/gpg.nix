{pkgs, ...}:
{
	programs.gpg = {
		enable = true;
	};
	services.gpg-agent = {
		enable = true;
		enableBashIntegration = true;
		pinentryPackage = pkgs.pinentry-all;
		enableSshSupport = true;
		# enableScDaemon = false;
		enableExtraSocket = true;
		verbose = true;
		extraConfig = ''
		'';
	};
}

