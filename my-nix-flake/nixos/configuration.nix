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
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nat = {
  enable = true;
  internalInterfaces = ["ve-+"];
  externalInterface = "enp0s20f0u3";
  # Lazy IPv6 connectivity for the container
  enableIPv6 = true;
};


containers.test = {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::2";
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

containers.psychoac = {
  autoStart = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.12";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::3";
  config = { config, pkgs, lib, ... }: {  
     users.users.alias = {
      isNormalUser = true;
      description = "Alias";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        neovim
	openssl
     ];
    };

    # Enable OpenSSH
    services.openssh.enable = true;    

    system.stateVersion = "24.11";

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443];
      };
      # Use systemd-resolved inside the container
      # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
      useHostResolvConf = lib.mkForce false;
    };
    
    services.resolved.enable = true;

    services.httpd = {
    	enable = true;
	enablePHP = true;
	virtualHosts."sound-of-science.org" = {
	  documentRoot = "/var/www/sound-of-science.org";
	};
    };

    services.mysql = {
	enable = true;
	package = pkgs.mariadb;
    };

    systemd.tmpfiles.rules = [
    "d /var/www/sound-of-science.org"
    "f /var/www/sound-of-science.org/index.php - - - - <?php phpinfo();"
    ];
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
  hardware.pulseaudio.enable = false;
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

  users.users.temp = {
    isNormalUser = true;
    description = "temp";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      neovim
      minicom
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
