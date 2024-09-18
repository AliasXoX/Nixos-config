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
        "SUPER, P, pseudo,"
	"SUPER, bracketleft, workspace, m-1"
        "SUPER, bracketright, workspace, m+1"
	"SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
	"SUPER, KP_End, workspace, 1"
	"SUPER, KP_Down, workspace, 2"
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
      monitor = "eDP-1,highres,0x0,1";
      };
      gestures = {
      	workspace_swipe = "true";
      };
      exec-once = ["hyprctl setcursor Dracula-cursors 24" "waybar" "swww-daemon & swww img ~/my-nix-flake/home-manager/wallpaper_3.png"];
    };
  };
}
