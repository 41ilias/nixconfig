{ config, lib, pkgs, ... }:

let
  # Dependencies
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils}/bin/cut";
  find = "${pkgs.findutils}/bin/find";
  grep = "${pkgs.gnugrep}/bin/grep";
  pgrep = "${pkgs.procps}/bin/pgrep";
  tail = "${pkgs.coreutils}/bin/tail";
  wc = "${pkgs.coreutils}/bin/wc";
  xargs = "${pkgs.findutils}/bin/xargs";
  timeout = "${pkgs.coreutils}/bin/timeout";
  ping = "${pkgs.iputils}/bin/ping";

  jq = "${pkgs.jq}/bin/jq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  wofi = "${pkgs.wofi}/bin/wofi";
in
{

  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };

  programs.waybar = {

    enable = true;
    systemd.enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });

    settings = {

      primaryBar = {

        layer = "top";
        margin = "5 0 0 0";
        spacing = 0;

        position = "top";
        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "group/hardware"
          "bluetooth"
          "network"
          "battery"
          "clock"
        ];

        "clock"= {
          format = " {:%H:%M}";
          format-alt = " {:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode           = "year";
            mode-mon-col   = 3;
            weeks-pos      = "right";
            on-scroll      = 1;
            on-click-right = "mode";
            format = {
              months =     "<span color='#ffead3'><b>{}</b></span>";
              days =       "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
              today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "battery" = {
          states = {
            # "good": 95,
            warning = 30;
            critical = 15;
          };
          format = "{icon}   {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{icon}  {time}";
          # "format-good": "", // An empty format will hide the module
          # "format-full": "",
          format-icons = [" " " " " " " " " "];
        };

        "network" = {
          format = "{ifname}";
          format-wifi = " {signalStrength}%";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = "Disconnected";
          tooltip = true;
          tooltip-format = "{ifname} via {gwaddri}";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
          tooltip-format-ethernet = "󰈀 {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
          tooltip-format-disconnected = "Disconnected";
          # on-click = "~/dotfiles/.settings/networkmanager.sh;
        };

        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          interval = 30;
          # on-click = "blueman-manager;
        };

        "cpu" = {
          format = "/ C {usage}% ";
          on-click = "kitty -1 btm";
        };
        "memory" = {
            format = "/ M {}% ";
            on-click = "kitty -1 btm";
        };
        "disk" = {
            interval = 30;
            format = "D {percentage_used}% ";
            path = "/";
            on-click = "kitty -1 btm";
        }; 

        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "not-memory";
            transition-left-to-right = false;
          };        
          modules = [
            "disk"
            "cpu"
            "memory"
          ];
        };
      };
    };

    style = ''
      @define-color backgroundlight #FFFFFF;
      @define-color backgrounddark #FFFFFF;
      @define-color workspacesbackground1 #FFFFFF;
      @define-color workspacesbackground2 #CCCCCC;
      @define-color bordercolor #FFFFFF;
      @define-color textcolor1 #000000;
      @define-color textcolor2 #000000;
      @define-color textcolor3 #FFFFFF;
      @define-color iconcolor #FFFFFF;

      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;

      * {
          font-family: 'Fira Sans', 'FiraCode Nerd Font';
          border: none;
          border-radius: 0px;
      }
      
      window#waybar {
          background-color: rgba(0,0,0,0.8);
          border-bottom: 0px solid #ffffff;
          /* color: #FFFFFF; */
          background: transparent;
          transition-property: background-color;
          transition-duration: .5s;
      }
      
      /* -----------------------------------------------------
       * Workspaces 
       * ----------------------------------------------------- */
      
      #workspaces {
          background: @workspacesbackground1;
          margin: 2px 1px 3px 1px;
          padding: 0px 1px;
          border-radius: 15px;
          border: 0px;
          font-weight: bold;
          font-style: normal;
          opacity: 0.8;
          font-size: 13px;
          color: @textcolor1;
      }
      
      #workspaces button {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 15px;
          border: 0px;
          color: @textcolor1;
          background-color: @workspacesbackground2;
          transition: all 0.3s ease-in-out;
          opacity: 0.4;
      }
      
      #workspaces button.active {
          color: @textcolor1;
          background: @workspacesbackground2;
          border-radius: 15px;
          min-width: 40px;
          transition: all 0.3s ease-in-out;
          opacity:1.0;
      }
      
      #workspaces button:hover {
          color: @textcolor1;
          background: @workspacesbackground2;
          border-radius: 15px;
          opacity:0.7;
      }
      
      /* -----------------------------------------------------
       * Tooltips
       * ----------------------------------------------------- */
      
      tooltip {
          border-radius: 10px;
          background-color: @backgroundlight;
          opacity:0.8;
          padding:20px;
          margin:0px;
      }
      
      tooltip label {
          color: @textcolor2;
      }
      
      /* -----------------------------------------------------
       * Window
       * ----------------------------------------------------- */
      
      #window {
          background: @backgroundlight;
          margin: 5px 15px 5px 0px;
          padding: 2px 10px 0px 10px;
          border-radius: 12px;
          color:@textcolor2;
          font-size:13px;
          font-weight:normal;
          opacity:0.8;
      }
      
      window#waybar.empty #window {
          background-color:transparent;
      }
      
      /* -----------------------------------------------------
       * Taskbar
       * ----------------------------------------------------- */
      
      #taskbar {
          background: @backgroundlight;
          margin: 3px 15px 3px 0px;
          padding:0px;
          border-radius: 15px;
          font-weight: normal;
          font-style: normal;
          opacity:0.8;
          border: 3px solid @backgroundlight;
      }
      
      #taskbar button {
          margin:0;
          border-radius: 15px;
          padding: 0px 5px 0px 5px;
      }
      
      /* -----------------------------------------------------
       * Modules
       * ----------------------------------------------------- */
      
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }
      
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }
      
      /* -----------------------------------------------------
       * Custom Quicklinks
       * ----------------------------------------------------- */
      
      #custom-brave, 
      #custom-browser, 
      #custom-keybindings, 
      #custom-outlook, 
      #custom-filemanager, 
      #custom-teams, 
      #custom-chatgpt, 
      #custom-calculator, 
      #custom-windowsvm, 
      #custom-cliphist, 
      #custom-wallpaper, 
      #custom-settings, 
      #custom-wallpaper, 
      #custom-system,
      #custom-waybarthemes {
          margin-right: 23px;
          font-size: 20px;
          font-weight: bold;
          opacity: 0.8;
          color: @iconcolor;
      }
      
      #custom-system {
          margin-right:15px;
      }
      
      #custom-wallpaper {
          margin-right:25px;
      }
      
      #custom-waybarthemes, #custom-settings {
          margin-right:20px;
      }
      
      #custom-chatgpt {
          margin-right: 15px;
          background-image: url("../assets/ai-icon.png");
          background-repeat: no-repeat;
          background-position: center;
          padding-right: 24px;
      }
      
      #custom-ml4w-welcome {
          margin-right: 15px;
          background-image: url("../assets/ml4w-icon.png");
          background-repeat: no-repeat;
          background-position: center;
          padding-right: 24px;
      }
      
      /* -----------------------------------------------------
       * Idle Inhibator
       * ----------------------------------------------------- */
      
      #idle_inhibitor {
          margin-right: 15px;
          font-size: 22px;
          font-weight: bold;
          opacity: 0.8;
          color: @iconcolor;
      }
      
      #idle_inhibitor.activated {
          margin-right: 15px;
          font-size: 20px;
          font-weight: bold;
          opacity: 0.8;
          color: #dc2f2f;
      }
      
      /* -----------------------------------------------------
       * Custom Modules
       * ----------------------------------------------------- */
      
      #custom-appmenu, #custom-appmenuwlr {
          background-color: @backgrounddark;
          font-size: 16px;
          color: @textcolor1;
          border-radius: 15px;
          padding: 0px 10px 0px 10px;
          margin: 3px 15px 3px 14px;
          opacity:0.8;
          border:3px solid @bordercolor;
      }
      
      /* -----------------------------------------------------
       * Custom Exit
       * ----------------------------------------------------- */
      
      #custom-exit {
          margin: 0px 20px 0px 0px;
          padding:0px;
          font-size:20px;
          color: @iconcolor;
      }
      
      /* -----------------------------------------------------
       * Custom Updates
       * ----------------------------------------------------- */
      
      #custom-updates {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }
      
      #custom-updates.green {
          background-color: @backgroundlight;
      }
      
      #custom-updates.yellow {
          background-color: #ff9a3c;
          color: #FFFFFF;
      }
      
      #custom-updates.red {
          background-color: #dc2f2f;
          color: #FFFFFF;
      }
      
      /* -----------------------------------------------------
       * Custom Youtube
       * ----------------------------------------------------- */
      
      #custom-youtube {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }
      
      /* -----------------------------------------------------
       * Hardware Group
       * ----------------------------------------------------- */
      
      #disk,#memory,#cpu,#language {
          margin:0px;
          padding:0px;
          font-size:13px;
          color:@iconcolor;
      }
      
      #language {
          margin-right:10px;
      }
      
      /* -----------------------------------------------------
       * Clock
       * ----------------------------------------------------- */
      
      #clock {
          background-color: #FFFFFF;
          font-size: 13px;
          color: #000000;
          border-radius: 15px;
          padding: 1px 10px 0px 10px;
          margin: 3px 15px 3px 0px;
          opacity:0.8;
          border:3px solid @teal;   
      }
      
      /* -----------------------------------------------------
       * Pulseaudio
       * ----------------------------------------------------- */
      
      #pulseaudio {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }
      
      #pulseaudio.muted {
          background-color: @backgrounddark;
          color: @textcolor1;
      }
      
      /* -----------------------------------------------------
       * Network
       * ----------------------------------------------------- */
      
      #network {
          background-color: @backgroundlight;
          font-size: 13px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }
      
      #network.ethernet {
          background-color: @backgroundlight;
          color: @textcolor2;
      }
      
      #network.wifi {
          background-color: @backgroundlight;
          color: @textcolor2;
      }
      
      /* -----------------------------------------------------
       * Bluetooth
       * ----------------------------------------------------- */
      
      #bluetooth, #bluetooth.on, #bluetooth.connected {
          background-color: @backgroundlight;
          font-size: 13px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }
      
      #bluetooth.off {
          background-color: transparent;
          padding: 0px;
          margin: 0px;
      }
      
      /* -----------------------------------------------------
       * Battery
       * ----------------------------------------------------- */
      
      #battery {
          background-color: @base;
          font-size: 13px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 15px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }
      
      #battery.charging, #battery.plugged {
          color: @textcolor2;
          background-color: @backgroundlight;
      }
      
      @keyframes blink {
          to {
              background-color: @backgroundlight;
              color: @textcolor2;
          }
      }
      
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: @textcolor3;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      /* -----------------------------------------------------
       * Tray
       * ----------------------------------------------------- */
      
      #tray {
          padding: 0px 15px 0px 0px;
      }
      
      #tray > .passive {
          -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

    '';
  };
}
