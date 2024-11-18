{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind = [
        "SUPER, F, exec, firefox"
        "SUPER, Q, exec, kitty"
        "SUPER, C, exec, google-chrome-stable"	
	"SUPER, R, exec, rofi -show drun"
        "SUPER, W, killactive,"
        "SUPER, Insert, fullscreen,"
        "SUPER, T, togglefloating,"
	"SUPER ALT, ,resizeactive,"
	"SUPER, bracketleft, workspace, m-1"
        "SUPER, bracketright, workspace, m+1"
	"SUPER SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
        "SUPER SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"
	"SUPER_SHIFT, left, exec, hyprnome --previous --move"
	"SUPER_SHIFT, right, exec, hyprnome --move"
	"SUPER, M, exec, prismlauncher"
	"SUPER, P, fullscreen"
	"SUPER, L, exec, hyprlock"
	"SUPER_SHIFT, R, exec, rofi-pass"
      ];
      binde = [
      	", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
	", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
	", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      bindl = [
      	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindm = [
      	"ALT, mouse:272, movewindow"
      	"SUPER, mouse:272, resizewindow"
      ];
      general = {
        border_size = "0";
        gaps_in = "2";
        gaps_out = "5";
      };
      decoration = {
        rounding = "1";
      };
      input = {
        kb_layout= "us";
        kb_variant = "intl";
        touchpad = {
          natural_scroll = "true";
        };
      monitor = ["eDP-1,highres,0x0,1" ", preferred, auto, 1"];
      };
      gestures = {
      	workspace_swipe = "true";
      };
      exec-once = [ "mako"  "hyprctl setcursor Dracula-cursors 24" "swww-daemon & swww img ./my-nix-flake/home-manager/wallpaper_3.png"];
    };
    plugins = [
    	pkgs.hyprlandPlugins.hyprtrails
	pkgs.hyprlandPlugins.hyprexpo
    ];
  };
}
