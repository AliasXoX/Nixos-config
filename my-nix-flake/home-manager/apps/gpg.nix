{pkgs, ...}:
{
	programs.gpg = {
		enable = true;
	};
	services.gpg-agent = {
		enable = true;
		enableBashIntegration = true;
		# pinentryPackage = pkgs.pinentry-curses;
		enableSshSupport = true;
		# enableScDaemon = false;
		enableExtraSocket = true;
		verbose = true;
		extraConfig = ''
debug-pinentry
debug-level 1024
pinentry-program /nix/store/n1fivd9hpql0wgb5pwzv8a1k8iv29dnk-pinentry-curses-1.3.1/bin/pinentry
		'';
	};
}
