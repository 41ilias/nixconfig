{ pkgs, lib, config, ... }:
{
  wayland.windowManager.hyprland.settings = {

    bind = let

      workspaces = [ 1 2 3 4 5 6 7 8 9 ];

      directions = rec {
        left = "l"; right = "r"; up = "u"; down = "d";
        h = left; l = right; k = up; j = down;
      };

      terminal = config.home.sessionVariables.TERMINAL;
      wofi = "${config.programs.wofi.package}/bin/wofi";
      alacritty = "${config.programs.alacritty.package}/bin/alacritty";
      qalc = "${pkgs.libqalculate}/bin/qalc";
      cliphist = "${pkgs.cliphist}/bin/cliphist";
      wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy}";
      grim = "${pkgs.grim}/bin/grim";
      slurp = "${pkgs.slurp}/bin/slurp";
      swappy = "${pkgs.swappy}/bin/swappy";
      convert = "${pkgs.imagemagick}/bin/convert";
      wofi-rbw = "${pkgs.rofi-rbw}/bin/rofi-rbw";

      ws = key: "SUPER, ${key}, workspace, ${key}";
      mv2ws = key: "SUPERSHIFT, ${key}, movetoworkspacesilent, ${key}";
      mvfocus = key: direction: "SUPER, ${key}, movefocus, ${direction}";
      swapWin = key: direction: "SUPERSHIFT, ${key}, swapwindow, ${direction}";

    in [
      "SUPER, Return, exec, ${terminal}"

      # Reload AGS
      # "SUPERSHIFT, R,  ${ags} quit; ags -b hypr"

      # Appluncher through AGS (doesn't show zathura so use wofi for now)
      # "SUPER, D, ${ags} -t applauncher"
      "SUPER, D, exec, ${wofi} -S drun -W 50% -H 30%"
      "SUPER, R, exec, ${wofi} -S run"

      "SUPER, Q, exec, ${alacritty} --hold -e ${qalc}" 

      "SUPER, C, exec, ${cliphist} list | ${wofi} --dmenu -p cliphist | ${cliphist} decode | ${wl-copy}"

      "SUPER, P, exec, ${grim} -g \"$(${slurp})\" - | ${convert} - -shave 1x1 PNG:- |  ${swappy} -f -"

      "SUPERSHIFT, Q, killactive"
      "SUPERSHIFT, E, exit"

      "SUPER, Tab, focuscurrentorlast"
      # "SUPERSHIFT, Tab, ${ags} -t overview"

      "SUPER, F, fullscreen, 1"
      "SUPERSHIFT, F, fullscreen, 0"

      "SUPERSHIFT, space, togglefloating"

      "SUPER,       m,      layoutmsg,      focustmaster,       master"
      "SUPERSHIFT,  M,      layoutmsg,      swapwithmaster"

      "SUPER,       minus,  splitratio,     -0.1"
      "SUPER,       equal,  splitratio,     0.1"

      "SUPER,s,togglespecialworkspace"
      "SUPERSHIFT,s,movetoworkspacesilent,special"

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

    bindl = [
      ",switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, 2256x1504, 0x0, 1\""
      ",switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
    ];

    bindle = let

      wpctl = "${pkgs.wireplumber}/bin/wpctl";
      light = "${pkgs.light}/bin/light";

    in [
      ",XF86MonBrightnessUp,    exec,   ${light} -T 1.4"
      ",XF86MonBrightnessDown,  exec,   ${light} -T 0.72"

      ",XF86AudioLowerVolume, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ 0 && ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioRaiseVolume, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ 0 && ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioMute,        exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
      # ",XF86AudioPlay, exec, playerctl --player=spotifyd play-pause"
      # ",XF86AudioNext, exec, playerctl --player=spotifyd next"
      # ",XF86AudioPrev, exec, playerctl --player=spotifyd previous"
    ];

    # bindl = let e = "exec, ags -b hypr -r"; in [
    #   ",XF86AudioPlay,    ${e} 'mpris?.playPause()'"
    #   ",XF86AudioStop,    ${e} 'mpris?.stop()'"
    #   ",XF86AudioPause,   ${e} 'mpris?.pause()'"
    #   ",XF86AudioPrev,    ${e} 'mpris?.previous()'"
    #   ",XF86AudioNext,    ${e} 'mpris?.next()'"
    #   ",XF86AudioMicMute, ${e} 'audio.microphone.isMuted = !audio.microphone.isMuted'"
    # ];

    bindm = [
      "SUPER, mouse:273, resizewindow"
      "SUPER, mouse:272, movewindow"
    ];
  };
}
