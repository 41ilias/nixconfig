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

  alacritty = "${pkgs.alacritty}/bin/alacritty";
  macchina = "${pkgs.macchina}/bin/macchina";
  btm = "${pkgs.bottom}/bin/btm";
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
        margin = "5 5 0 5";
        spacing = 0;
        position = "top";

        modules-left = [
          "custom/system"
          "clock"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
         "network#eth"
         "network#wifi"
         "bluetooth"
         "pulseaudio#speaker"
         "pulseaudio"
         "battery"
         "group/hardware"
         "tray"
        ];

        "custom/system" = {
          format = "  ";
          tooltip = false;
          on-click = "${alacritty} --hold -e ${macchina}"; # TODO: fix it 
        };

        "clock" = {
          actions = {
            on-click-right = "mode";
          };
          calendar = {
            format = {
              days = "<span color='#b4befe'><b>{}</b></span>";
              months = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
              weekdays = "<span color='#fab387'><b>{}</b></span>";
              weeks = "<span color='#89dceb'><b>W{}</b></span>";
            };
            mode = "year";
            mode-mon-col = 3;
            on-click-right = "mode";
            on-scroll = 1;
            weeks-pos = "right";
          };
          format = " {:%H:%M  󰃭 %a %d/%m}";
          format-alt = "󰃭 {:%A; %B %d, %Y 󰥔 %R}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "network#eth" = {
          interface = "eth0";
          format-ethernet = "󰈀 {ipaddr}";
          format-linked = "󰈀 No IP";
          tooltip = true;
          tooltip-format = "{ifname}";
          tooltip-format-ethernet = "󰈀 {ifname}\n󰩟 {ipaddr}\n {bandwidthDownBits}   {bandwidthUpBits}";
        };

        "network#wifi" = {
          interface = "wlp1s0";
          format-disconnected = "󰤭  off";
          format-wifi = "  {essid}";
          tooltip-format-disconnected = "󰤯 is off or 󱖣  Not Connected";
          tooltip-format-wifi = "  {ifname} 󰵪 {essid}\n󰩟 {ipaddr}\n󱅝 {signalStrength}%\n󰐻 {frequency}GHz\n {bandwidthDownBits}   {bandwidthUpBits}";
        };

        "bluetooth" = {
	      format-on = " {status}";
	      format-connected = " {device_alias}";
	      format-connected-battery = " {device_alias}   {device_battery_percentage}%";
	      format-device-preference = [ "Soundcore Liberty 3 Pro" "Soundcore Life Q30" "BT60 V2" ];
	      tooltip-format = "󰌢 {controller_alias} {controller_address}\n󰵮 {num_connections} connected";
	      tooltip-format-connected = "󰌢 {controller_alias} {controller_address}\n󰵮 {num_connections} connected\n{device_enumerate}";
	      tooltip-format-enumerate-connected = " {device_alias} 󰻾 {device_address}";
	      tooltip-format-enumerate-connected-battery = " {device_alias} 󰻾 {device_address}   {device_battery_percentage}%";
        };

        # This will only show up when volume of speakers > 0 and it's the current sink
        "pulseaudio#speaker" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [ "" "" ];
          };
          states = {
            critical = 0;
          };
          format-critical = "";
          ignored-sinks = [
            "PCM2902 Audio Codec Analog Stereo"
            "Soundcore Liberty 3 Pro"
            "Soundcore Life Q30"
          ];
          scroll-step = 1;
          on-click = "pavucontrol";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            hands-free = "󱡏";
            default = [ "" "" ];
          };
          ignored-sinks = [
            "Family 17h/19h HD Audio Controller Analog Stereo"
          ];
          scroll-step = 1;
          on-click = "pavucontrol";
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-alt = "{icon} {time}";
          tooltip-format = "󰔟 {timeTo}";
          format-plugged = "  {capacity}%";
          format-charging = " {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
          states = {
            critical = 10;
            warning = 20;
          };
        };

        "cpu" = {
          format = "  {usage}%";
          on-click = "${alacritty} --hold -e ${btm}";
        };
        "memory"= {
          format = "󰍛 {used}GiB";
          on-click = "${alacritty} --hold -e ${btm}";
        };
        "disk"= {
          format = "󰆼 {free}";
          interval = 60;
          on-click = "${alacritty} --hold -e ${btm}";
          path = "/";
        };
        "group/hardware" = {
          drawer = {
            children-class = "not-memory";
            transition-duration = 300;
            transition-left-to-right = true;
          };
          modules = [
            "cpu"
            "disk"
            "memory"
          ];
          orientation = "inherit";
        };
      };
    };

    style = ''
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
          font-family: 'FiraCode Nerd Font';
          font-size: 15px;
          font-weight: bold;
          border: none;
          border-radius: 0px;
      }
      
      window#waybar {
          background: transparent;
          transition-property: background-color;
          transition-duration: .5s;
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
       * Workspaces 
       * ----------------------------------------------------- */
      
      #workspaces {
          background: @crust;
      
          margin: 2px 1px 3px 1px;
          padding: 0px 1px;
          border-radius: 15px;
          border: 0px;
          font-size: 23px;
          font-weight: bold;
          font-style: normal;
          opacity: 0.8;
          border:2px solid @overlay2;   
      }
      
      #workspaces button {
          background-color: @base;
          color: @teal;
      
          padding: 2px 5px 0px 5px;
          font-size: 23px;
          margin: 4px 3px;
          border-radius: 15px;
          border: 0px;
          transition: all 0.3s ease-in-out;
          opacity: 0.4;
      }
      
      #workspaces button:hover {
          background: @sky;
          color: @base;
      
          font-size: 23px;
          border-radius: 15px;
          opacity:0.7;
      }
      
      #workspaces button.active {
          background: @teal;
          color: @base;
      
          font-size: 23px;
          border-radius: 15px;
          min-width: 40px;
          transition: all 0.3s ease-in-out;
          opacity:1.0;
      }
      
      /* -----------------------------------------------------
       * Tooltips
       * ----------------------------------------------------- */
      
      tooltip {
          border-radius: 10px;
          border:2px solid @overlay2;   
          background-color: @base;
      }
      
      tooltip label {
          font-size: 19px;
          font-weight: normal;
          color: @text;
          margin: 15px 15px 5px 15px;
      }
      
      /* -----------------------------------------------------
       * Custom System
       * ----------------------------------------------------- */
      #custom-system {
          background-color: @blue;
          color: @crust;
          font-size: 25px;
          font-weight: bold;
          margin-right:15px;
          border-radius: 15px;
          padding: 1px 15px 0px 7px;
          margin: 3px 15px 3px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
      }
      
      /* -----------------------------------------------------
       * Clock
       * ----------------------------------------------------- */
      #clock {
          background-color: @pink;
          color: @crust;
          border-radius: 15px;
          padding: 1px 10px 0px 10px;
          margin: 3px 15px 3px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
      }
      
      /* -----------------------------------------------------
       * Network
       * ----------------------------------------------------- */
      
      #network {
          background-color: @flamingo;
          color: @crust;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
      }
      
      #network.eth {
          background-color: @green;
      }
      
      /* -----------------------------------------------------
       * Bluetooth
       * ----------------------------------------------------- */
      
      #bluetooth, #bluetooth.on, #bluetooth.connected {
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
      }
      
      #bluetooth.off {
          background-color: @crust;
          color: @lavender;
      }
      
      @keyframes blink {
          to {
              background-color: @crust;
              color: @red;
          }
      }
      
      #bluetooth.on {
          background-color: @red;
          color: @crust;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      #bluetooth.connected {
          background-color: @lavender;
          color: @crust;
      }
      
      /* -----------------------------------------------------
       * Pulseaudio
       * ----------------------------------------------------- */
      
      #pulseaudio {
          background-color: @sky;
          color: @crust;
          border-radius: 15px;
          padding: 2px 15px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
      }
      
      #pulseaudio.speaker {
          animation-name: blink;
          animation-duration: 2s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      #pulseaudio.muted {
          background-color: @sapphire;
          color: @crust;
      }
      
      /* -----------------------------------------------------
       * Battery
       * ----------------------------------------------------- */
      
      #battery {
          background-color: @rosewater;
          color: @crust;
          border-radius: 15px;
          padding: 2px 15px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
      }
      
      #battery.critical:not(.charging) {
          background-color: @red;
          color: @crust;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      #battery.warning:not(.charging) {
          background-color: @yellow;
          color: @crust;
          animation-name: blink;
          animation-duration: 2s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      /* -----------------------------------------------------
       * Hardware Group
       * ----------------------------------------------------- */
      
      #disk,#memory,#cpu {
          background-color: @sapphire;
          color: @crust;
      
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
          border:2px solid @overlay2;   
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
