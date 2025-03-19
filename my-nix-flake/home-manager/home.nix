{ config, pkgs, lib, inputs, ... }:

{
  home.username = "alias";
  home.homeDirectory = "/home/alias";
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.tldr
    pkgs.htop
    pkgs.google-chrome
    pkgs.jetbrains.pycharm-professional
    pkgs.jetbrains.ruby-mine
    pkgs.brightnessctl
    pkgs.libnotify
    pkgs.swww
    pkgs.wl-clipboard
    pkgs.arduino
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
    pkgs.pinentry-gtk2
    pkgs.minicom
    pkgs.nautilus   
    pkgs.lime3ds
    pkgs.musescore
    pkgs.postgresql
    pkgs.android-studio
    pkgs.hyprshot
    pkgs.flatpak
  ];

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
  imports = [
     ./apps/git.nix
     ./apps/hyprland.nix
     ./apps/waybar.nix
     ./apps/poetry.nix
     ./apps/kitty.nix
     ./apps/mako.nix
     ./apps/rofi.nix
#     ./apps/xdg_portal.nix
     ./apps/neovim.nix
     ./apps/hyprlock.nix
     ./apps/rofi-pass.nix
     ./apps/gpg.nix
     ./apps/pass.nix
     ./apps/vscode.nix
     ./apps/java.nix
  ];
}
