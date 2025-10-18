{ inputs, lib, config, pkgs, ... }:
let
  # hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
{
  imports = [
    ../common
    ../common/wayland-wm
    ./basic-binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    # plugins = with plugins; [ hyprbars ];


    settings = {

      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,36"
      ];

      exec-once = [
        "sway-audio-idle-inhibit"
      ];

      exec = [
        "wpaperd"
      ];

      monitor = [
        "eDP-1,                                             2256x1504,  0x2160,     1"
        "desc:Samsung Electric Company LU28R55 HNMR202267,  3840x2160,  0x0,        1"
        "desc:Samsung Electric Company C27F390 HTQH502177,  1920x1080,  -1080x0,    1,  transform,  1"
        # For random moniotrs
        ",                                                  highres,    2256x2160,  1"
      ];

      workspace = [
        "name:Mirror, monitor:DP-4,                                             default:true"
        "name:Docs,   monitor:desc:Samsung Electric Company C27F390 HTQH502177,             , on-created-empty:firefox, layoutopt:orientation:top"
        "2,           monitor:desc:Samsung Electric Company LU28R55 HNMR202267, default:true, on-created-empty:firefox"
        "3,           monitor:desc:Samsung Electric Company LU28R55 HNMR202267, default:true, on-created-empty:kitty"
      ];

      general = {
        border_size = 3;
        gaps_out = 10;
        gaps_in = 5;
        "col.active_border" = "rgba(94e2d5ff) rgba(89b4faff) 45deg";
        "col.inactive_border" = "rgba(89b4fa50) rgba(94e2d550) 225deg";

        # cursor_inactive_timeout = 30;
        layout = "master";

        resize_on_border = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        numlock_by_default = true;

        # accel_profile = "adaptive";
        # sensitivity = 0.2;

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
        };
      };

      binds = {
        allow_workspace_cycles = true;
      };

      misc = {
        layers_hog_keyboard_focus = false;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      master = {
        mfact = 0.6;
        new_status = "slave";
      };

  #     windowrule = let
  #       f = regex: "float, ^(${regex})$";
  #     in [
		# (f "pavucontrol")
		# (f "nm-connection-editor")
		# (f "xdg-desktop-portal")
		# (f "xdg-desktop-portal-gtk")
		# (f "PacketTracer")
  #     ];

      windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "float,class:(PacketTracer),title:(kitty)"
        "float,class:(Alacritty),title:(Alacritty)"
        "nodim,title:^Wayland Output Mirror"
        "opaque,title:^Wayland Output Mirror"
        "fullscreen,title:^Wayland Output Mirror"
        "workspace name:Mirror,title:^Wayland Output Mirror"

        # TODO: remove after project
        "float,class:(Tk),title:(ttkbootstrap)"
        "float,class:(Tk),title:(CryptoSRK)"
        "move onscreen cursor 0 0 ,class:(Tk),title:(CryptoSRK)"
        "size 900 500,class:(TkChooseDir)"
        "center,class:(TkChooseDir)"
      ];

      decoration = {
        rounding = 15;

        active_opacity = 1;
        inactive_opacity = 0.80;

        # drop_shadow = true;
        # shadow_range = 8;
        # shadow_render_power = 2;
        # "col.shadow" = "rgba(00000044)";

        dim_inactive = true;
        dim_strength = 0.2;
        dim_special = 0.2;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
    };
  };
}
