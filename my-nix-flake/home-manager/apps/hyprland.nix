{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind = [
        "SUPER, F, exec, firefox"
        "SUPER, Q, exec, kitty"
        "SUPER, C, exec, google-chrome-stable"
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
      exec-once = "waybar";
    };
  };
}
