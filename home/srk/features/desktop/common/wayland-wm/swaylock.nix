{ config, pkgs, ... }:

let inherit (config.colorscheme) colors;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "20x3";
      fade-in = 0.2;

      screenshots = true;

      font = "FiraCode Nerd Font";
      font-size = 70;

      clock = true;
      timestr = "%R";
      datestr = "%a, %d %b %Y";

      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 350;
      indicator-thickness = 35;
      indicator-idle-visible = true;

      ignore-empty-password = true;

      color = "#1e1e2e";
      bs-hl-color = "#f5e0dc";
      caps-lock-bs-hl-color = "#f5e0dc";
      caps-lock-key-hl-color = "#a6e3a1";
      inside-color = "#00000000";
      inside-clear-color = "#00000000";
      inside-caps-lock-color = "#00000000";
      inside-ver-color = "#00000000";
      inside-wrong-color = "#00000000";
      key-hl-color = "#a6e3a1";
      layout-bg-color = "#00000000";
      layout-border-color = "#00000000";
      layout-text-color = "#cdd6f4";
      line-color = "#00000000";
      line-clear-color = "#00000000";
      line-caps-lock-color = "#00000000";
      line-ver-color = "#00000000";
      line-wrong-color = "#00000000";
      ring-color = "#b4befe";
      ring-clear-color = "#f5e0dc";
      ring-caps-lock-color = "#fab387";
      ring-ver-color = "#89b4fa";
      ring-wrong-color = "#eba0ac";
      separator-color = "#00000000";
      text-color = "#cdd6f4";
      text-clear-color = "#f5e0dc";
      text-caps-lock-color = "#fab387";
      text-ver-color = "#89b4fa";
      text-wrong-color = "#eba0ac";
    };
  };
}
