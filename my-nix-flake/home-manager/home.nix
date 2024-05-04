{ config, pkgs, lib, inputs, ... }:

{
  home.username = "alias";
  home.homeDirectory = "/home/alias";
  home.stateVersion = "23.11";
  home.packages = [
    pkgs.neovim
    pkgs.tldr
    pkgs.htop
    pkgs.kitty
    pkgs.chromium
    pkgs.google-chrome
  ];
 
  programs.home-manager.enable = true;

  imports = [
     ./apps/git.nix
     ./apps/hyprland.nix
     ./apps/waybar.nix
  ];
}
