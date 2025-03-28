# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  /*boot.loader = {
  	grub = {
		forceInstall = false;

		enable = true;
		useOSProber = true;
		copyKernels = true;
		efiSupport = true;
		efiInstallAsRemovable = false;
		fsIdentifier = "label";
		devices = ["nodev"];
		extraEntries = ''
			menu entry "Reboot" {
				reboot
			}
			menu entry "Poweroff" {
				halt
			}
		'';
		minegrub-theme = {
      			enable = false;
      			splash = "100% Flakes!";
      			background = "background_options/1.8  - [Classic Minecraft].png";
      			boot-options-count = 4;
    		};
	};
  };*/
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
  networking.nat = {
  enable = true;
  internalInterfaces = ["ve-+"];
  externalInterface = "wlp1s0";
  # Lazy IPv6 connectivity for the container
  enableIPv6 = true;
};


containers.test = {
  autoStart = true;
  privateNetwork = false;
  #hostAddress = "192.168.100.10";
  #localAddress = "192.168.100.11";
  #hostAddress6 = "fc00::1";
  #localAddress6 = "fc00::2";
  config = { config, pkgs, lib, ... }: {  
     users.users.alias = {
      isNormalUser = true;
      description = "Alias";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        neovim
	git
	freeradius
	openssl
	python314
     ];
    };

    # Enable OpenSSH
    services.openssh.enable = true;    

    system.stateVersion = "24.11";

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 80 ];
      };
      # Use systemd-resolved inside the container
      # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
      useHostResolvConf = lib.mkForce false;
    };
    
    services.resolved.enable = true;

  };
};

containers.tibProd = {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  config = { config, pkgs, lib, ... }: {
     
     environment.systemPackages = with pkgs; [
       neovim
       git
     ];

	services.nginx = {
	  enable = true;
	  virtualHosts.localhost = {
	    root = "/var/www/site_tib_prod";
	  };
	};


         # Enable OpenSSH
    services.openssh.enable = true;    

    system.stateVersion = "24.11";

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 80 ];
      };
      # Use systemd-resolved inside the container
      # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
      useHostResolvConf = lib.mkForce false;
      extraHosts =
        ''127.0.0.3 blog.example.com
        '';
    };
    
    services.resolved.enable = true;


  };
};



  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable postgresql

  services.postgresql = {
	enable = true;
    	ensureDatabases = [ "mydatabase" ];
    	authentication = pkgs.lib.mkOverride 10 ''
      	#type database  DBuser  auth-method
      	local all       all     trust
    	'';
};

  # Enable the X11 windowing system.

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;
  # Configure keymap in X11
#  services.xserver = {
#    xkb.layout = "us";
#    xkb.variant = "alt-intl";
#  };
  
  # Enable hyprlock
  security.pam.services.hyprlock = {};

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alias = {
    isNormalUser = true;
    description = "Alias";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  services.pcscd.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
   
  # Enable flakes 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND= "1";
    VAULT_ADDR = "https://vault.rezoleo.fr";
  };

  environment.variables = {
    VAULT_ADDR = "https://vault.rezoleo.fr";
  };

  fonts.packages = [
    pkgs.font-awesome
  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
