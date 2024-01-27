{ inputs, lib, config, pkgs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};

  launcher = pkgs.writeShellScriptBin "hypr" ''
    #!/${pkgs.bash}/bin/bash

    export WLR_NO_HARDWARE_CURSORS=1
    export _JAVA_AWT_WM_NONREPARENTING=1

    exec ${hyprland}/bin/Hyprland
  '';
in
{
  imports = [
    ../common
    ../common/wayland-wm
    ./basic-binds.nix
  ];

  home.packages = [ launcher ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    systemd.enable = true;
    xwayland.enable = true;

    # plugins = with plugins; [ hyprbars ];

    settings = {
      exec-once = [
        "ags -b hypr"
        "hyprctl setcursor Qogir 24"
      ];

      monitor = [
        "DP-1, preferred, 1080x640, auto"
        "DP-2, preferred, 0x0, 1, transform, 1"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        numlock_by_default = true;
        touchpad.disable_while_typing = false;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      misc = {
        layers_hog_keyboard_focus = false;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = "yes";
      };

      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
		(f "org.gnome.Calculator")
		(f "org.gnome.Nautilus")
		(f "pavucontrol")
		(f "nm-connection-editor")
		(f "blueberry.py")
		(f "org.gnome.Settings")
		(f "org.gnome.design.Palette")
		(f "Color Picker")
		(f "xdg-desktop-portal")
		(f "xdg-desktop-portal-gnome")
		(f "transmission-gtk")
		(f "com.github.Aylur.ags")
      ];

      windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];

      decoration = {
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

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
