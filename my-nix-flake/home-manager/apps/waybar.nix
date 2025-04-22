{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];
      modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
      modules-center = [ "sway/window" "hyprland/workspaces" ];
      modules-right = [ "network" "pulseaudio" "cpu" "battery" "clock" "custom/power" ];

      "hyprland/workspaces" = {
	active-only = true;
        all-outputs = false;
        format = "{icon}";
      };

      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };

      "pulseaudio" = {
      	format = "{volume}% 🔊";
	format-muted = "🔇";
      };

      "custom/power" = {
        format = "⏻";
        on-click = "shutdown -h now";
      };

      "tray" = {
         spacing = 10;
       };

      "clock" = {
        format-alt = "{:%Y-%m-%d}";
      };

      "cpu" = {
        format = "{usage}% ";
      };

      "battery" = {
        bat = "BAT0";
        states = {
          "good" = 95;
          "warning" = 20;
          "critical" = 10;
        };
        format = "{capacity}% {icon}";
        format-icons = ["" "" "" "" ""];
      };

      "network" = {
        interval = 1;
        format-wifi = "{essid} {signalStrength}% ";
        format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
        tooltip-format-wifi = "{ipaddr} ({signalStrength}%)";
        tooltip-format = "{ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
      };
     };
    };
    
    style = "
     * {
    border: none;
    border-radius: 0;
    font-family: 'Ubuntu Nerd Font';
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background: transparent;
    color: white;
}

#window {
    font-weight: bold;
    font-family: 'Ubuntu';
}
/*
#workspaces {
    padding: 0 5px;
}
*/

#workspaces button {
    padding: 0 5px;
    background: transparent;
    color: white;
    border-top: 2px solid transparent;
}

#workspaces button.focused {
    color: #c9545d;
    border-top: 2px solid #c9545d;
}

#mode {
    background: #64727D;
    border-bottom: 3px solid white;
}

#clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
    padding: 0 3px;
    margin: 0 2px;
}

#clock {
    font-weight: bold;
}

#battery {
}

#battery icon {
    color: red;
}

#battery.charging {
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: black;
    }
}

#battery.warning:not(.charging) {
    color: white;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#cpu {
}

#memory {
}

#network {
}

#network.disconnected {
    background: #f53c3c;
}

#pulseaudio {
}

#pulseaudio.muted {
}

#custom-spotify {
    color: rgb(102, 220, 105);
}

#tray {
}

    ";
  };
}
