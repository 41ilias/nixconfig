{ lib, config, ... }:
{
  wayland.windowManager.hyprland.settings = {

    workspace = [
      "1,  name:1, monitor:DP-2, persistent:true, default:true"
      "2,  name:2, monitor:DP-1, persistent:true, default:true"
      "3,  name:3, monitor:DP-1, persistent:false"
      "4,  name:4, monitor:DP-1, persistent:false"
      "5,  name:5, monitor:DP-1, persistent:false"
      "6,  name:6, monitor:DP-1, persistent:false"
      "7,  name:7, monitor:DP-1, persistent:false"
      "8,  name:8, monitor:DP-1, persistent:false"
      "9,  name:9, monitor:DP-1, persistent:false"
      "10, name:0, monitor:DP-2, persistent:false"
    ];

    bind = let

      workspaces = [ 1 2 3 4 5 6 7 8 9 ];

      directions = rec {
        left = "l"; right = "r"; up = "u"; down = "d";
        h = left; l = right; k = up; j = down;
      };

      ags = "exec, ags -b hypr";

      terminal = config.home.sessionVariables.TERMINAL;
      wofi = "${config.programs.wofi.package}/bin/wofi";

      ws = key: "SUPER, ${key}, workspace, ${key}";
      mv2ws = key: "SUPERSHIFT, ${key}, movetoworkspacesilent, ${key}";
      mvfocus = key: direction: "SUPER, ${key}, movefocus, ${direction}";
      swapWin = key: direction: "SUPERSHIFT, ${key}, swapwindow, ${direction}";

    in [
      "SUPER, Return, exec, ${terminal}"

      # Reload AGS
      "SUPERSHIFT, R,  ${ags} quit; ags -b hypr"

      # Appluncher through AGS (doesn't show zathura so use wofi for now)
      # "SUPER, D, ${ags} -t applauncher"
      "SUPER, D, exec, ${wofi} -S drun -W 50% -H 30%"
      "SUPER, R, exec, ${wofi} -S run"


      "SUPERSHIFT, Q, killactive"
      "SUPERSHIFT, E, exit"


      "SUPER, Tab, focuscurrentorlast"
      "SUPERSHIFT, Tab, ${ags} -t overview"

      "SUPER, F, fullscreen, 1"
      "SUPERSHIFT, F, fullscreen, 0"

      "SUPERSHIFT, space, togglefloating"

      "SUPER,minus,splitratio,-0.25"
      "SUPERSHIFT,minus,splitratio,-0.3333333"

      "SUPER,equal,splitratio,0.25"
      "SUPERSHIFT,equal,splitratio,0.3333333"

      "SUPER,u,togglespecialworkspace"
      "SUPERSHIFT,u,movetoworkspacesilent,special"

      "SUPER, O, fakefullscreen"
      "SUPER, P, togglesplit"
      
      # 0 is workspace 10 (easier this way than using map and workspaces)
      "SUPER, 0, workspace, 10"
      "SUPERSHIFT, 0, movetoworkspacesilent, 10"
    ]
    ++ (map (key: ws (toString key)) workspaces)
    ++ (map (key: mv2ws (toString key)) workspaces)
    ++ (lib.mapAttrsToList (key: direction: mvfocus key direction) directions)
    ++ (lib.mapAttrsToList (key: direction: swapWin key direction) directions);

    bindle = let e = "exec, ags -b hypr -r"; in [
      ",XF86AudioRaiseVolume,  ${e} 'audio.speaker.volume += 0.05; indicator.speaker()'"
      ",XF86AudioLowerVolume,  ${e} 'audio.speaker.volume -= 0.05; indicator.speaker()'"
    ];

    bindl = let e = "exec, ags -b hypr -r"; in [
      ",XF86AudioPlay,    ${e} 'mpris?.playPause()'"
      ",XF86AudioStop,    ${e} 'mpris?.stop()'"
      ",XF86AudioPause,   ${e} 'mpris?.pause()'"
      ",XF86AudioPrev,    ${e} 'mpris?.previous()'"
      ",XF86AudioNext,    ${e} 'mpris?.next()'"
      ",XF86AudioMicMute, ${e} 'audio.microphone.isMuted = !audio.microphone.isMuted'"
    ];

    bindm = [
      "SUPER, mouse:273, resizewindow"
      "SUPER, mouse:272, movewindow"
    ];
  };
}
