{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-left = 16;
        margin-right = 16;
        modules-left = [
          "custom/launcher"
          "wlr/workspaces"
          "custom/weather"
        ];
        modules-center = [
          "mpris"
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "custom/notification"
          "tray"
          "custom/clipboard"
        ];

        "custom/launcher" = {
          format = " ";
          on-click = "nwg-drawer";
          tooltip = false;
        };
        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };
        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = "curl -s 'https://wttr.in/Petropolis?format=1'";
          return-type = "text";
          on-click = "gnome-weather";
        };
        "mpris" = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
            spotify = "";
            firefox = "";
          };
          status-icons = {
            paused = "⏸";
          };
          dynamic-len = 40;
        };
        "clock" = {
          format = " {:%H:%M - %d/%m}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          on-click = "gnome-calendar";
          calendar = {
            mode = "month";
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        "custom/clipboard" = {
          format = "";
          on-click = "fuzzel -d | cliphist decode | wl-copy";
          tooltip = false;
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pwvucontrol";
          scroll-step = 5;
        };
        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "⚠ Off";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "nm-connection-editor";
        };
        "custom/notification" = {
          tooltip = false;
          format = " ";
          on-click = "swaync-client -t -sw";
          escape = true;
        };
      };
    };
    style = ''
      * { border: none; border-radius: 0; font-family: "JetBrainsMono Nerd Font", sans-serif; font-size: 15px; font-weight: bold; min-height: 0; }
      window#waybar { background: transparent; color: #cdd6f4; }
      #custom-launcher, #workspaces, #custom-weather, #mpris, #clock, #pulseaudio, #network, #battery, #custom-notification, #tray {
        background: rgba(30, 30, 46, 0.85); border-radius: 12px; margin: 4px; padding: 4px 16px; border: 2px solid #313244;
      }
      #custom-launcher { color: #89b4fa; font-size: 18px; padding-right: 18px; }
      #workspaces button { color: #bac2de; padding: 0 8px; }
      #workspaces button.active { color: #cba6f7; }
      #custom-weather { color: #fab387; }
      #mpris { color: #cba6f7; }
      #clock { color: #89b4fa; }
      #pulseaudio { color: #a6e3a1; }
      #network { color: #f9e2af; }
      #custom-notification { color: #f38ba8; }
    '';
  };
}
