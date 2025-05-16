{ config, pkgs, lib, inputs, ... }:

{
  home.username = "alias";
  home.homeDirectory = "/home/alias";
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.tldr
    pkgs.htop
    pkgs.google-chrome
    pkgs.jetbrains.ruby-mine
    pkgs.brightnessctl
    pkgs.libnotify
    pkgs.swww
    pkgs.wl-clipboard
    pkgs.shutter
    pkgs.pulseaudio
    pkgs.pavucontrol
    pkgs.dracula-theme
    pkgs.vault
    pkgs.prismlauncher
    pkgs.reaper # sound mixing software
    pkgs.cargo
    pkgs.rustc
    pkgs.inter
    pkgs.papirus-icon-theme
    pkgs.hyprnome # Manage workspace in hyprland like GNOME
    pkgs.filezilla # Filezilla
    pkgs.minicom
    pkgs.nautilus   
    #pkgs.lime3ds
    pkgs.musescore
    pkgs.postgresql
    pkgs.android-studio
    pkgs.hyprshot
    pkgs.flatpak
    pkgs.hyprsunset
    pkgs.strawberry
    pkgs.vlc
    pkgs.alsa-utils
    pkgs.webex
  ];

  home.sessionVariables = {
  	XDG_RUNTIME_DIR = "run/user/$UID";
  };

  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          # x11.enable = true;
          name = name;
          size = 48;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.0/Fuchsia-Pop.tar.gz"
        "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
        "Fuchsia-Pop";
 
  programs.home-manager.enable = true;

  programs.bash.enable = true;

  imports = [
     ./apps/git.nix
     ./apps/hyprland.nix
     ./apps/waybar.nix
     #./apps/poetry.nix
     ./apps/kitty.nix
     ./apps/mako.nix
     ./apps/rofi.nix
     ./apps/xdg_portal.nix
     ./apps/neovim.nix
     ./apps/hyprlock.nix
     ./apps/rofi-pass.nix
     ./apps/gpg.nix
     ./apps/pass.nix
     ./apps/vscode.nix
     ./apps/java.nix
     ./apps/direnv.nix
  ];
}
