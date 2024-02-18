{ config, pkgs, ... }:

let
  rosewater = "f5e0dc";
  flamingo = "f2cdcd";
  pink = "f5c2e7";
  mauve = "cba6f7";
  red = "f38ba8";
  maroon = "eba0ac";
  peach = "fab387";
  yellow = "f9e2af";
  green = "a6e3a1";
  teal = "94e2d5";
  sky = "89dceb";
  sapphire = "74c7ec";
  blue = "89b4fa";
  lavender = "b4befe";
  text = "cdd6f4";
  subtext1 = "bac2de";
  subtext0 = "a6adc8";
  overlay2 = "9399b2";
  overlay1 = "7f849c";
  overlay0 = "6c7086";
  surface2 = "585b70";
  surface1 = "45475a";
  surface0 = "313244";
  base = "1e1e2e";
  mantle = "181825";
  crust = "11111b";
in
{

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "text/xml" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/qute" = [ "org.qutebrowser.qutebrowser.desktop" ];
  };

  programs.qutebrowser = {
    enable = false;
    loadAutoconfig = true;
    settings = {
      editor.command = [ "xdg-open" "{file}" ];
      tabs = {
        show = "multiple";
        position = "left";
      };
      fonts = {
        default_family =  "FiraCode Nerd Font";
        default_size = "13pt";
      };
      colors = {
        webpage = {
          darkmode.enabled = true;
          bg = "#${base}";
        };
        completion = {
          fg = "#${subtext0}";
          match.fg = "#${text}";
          even.bg = "#${mantle}";
          odd.bg = "#${crust}";
          scrollbar = {
            bg = "#${crust}";
            fg = "#${surface2}";
          };
          category = {
            bg = "#${base}";
            fg = "#${green}";
            border = {
              bottom = "#${mantle}";
              top = "#${overlay2}";
            };
          };
          item.selected = {
            bg = "#${surface2}";
            fg = "#${text}";
            match.fg = "#${rosewater}";
            border = {
              bottom = "#${surface2}";
              top = "#${surface2}";
            };
          };
        };
        contextmenu = {
          disabled = {
            bg = "#${mantle}";
            fg = "#${overlay0}";
          };
          menu = {
            bg = "#${base}";
            fg = "#${text}";
          };
          selected = {
            bg = "#${overlay0}";
            fg = "#${rosewater}";
          };
        };
        downloads = {
          bar.bg = "#${base}";
          error = {
            bg = "#${base}";
            fg = "#${red}";
          };
          start = {
            bg = "#${base}";
            fg = "#${blue}";
          };
          stop = {
            bg = "#${base}";
            fg = "#${green}";
          };
        };
        hints = {
          bg = "#${peach}";
          fg = "#${mantle}";
          match.fg = "#${subtext1}";
        };
        keyhint = {
          bg = "#${mantle}";
          fg = "#${text}";
          suffix.fg = "#${subtext1}";
        };
        messages = {
          error.bg = "#${overlay0}";
          error.border = "#${mantle}";
          error.fg = "#${red}";
          info.bg = "#${overlay0}";
          info.border = "#${mantle}";
          info.fg = "#${text}";
          warning.bg = "#${overlay0}";
          warning.border = "#${mantle}";
          warning.fg = "#${peach}";
        };
        prompts = {
          bg = "#${mantle}";
          fg = "#${text}";
          border = "1px solid #${overlay0}";
          selected.bg = "#${surface2}";
          selected.fg = "#${rosewater}";
        };
        statusbar = {
          normal = {
            bg = "#${base}";
            fg = "#${text}";
          };
          insert.bg = "#${crust}";
          insert.fg = "#${rosewater}";
          command = {
            bg = "#${base}";
            fg = "#${text}";
            private.bg = "#${base}";
            private.fg = "#${subtext1}";
          };
          caret = {
            bg = "#${base}";
            fg = "#${peach}";
            selection.bg = "#${base}";
            selection.fg = "#${peach}";
          };
          passthrough.bg = "#${base}";
          passthrough.fg = "#${peach}";
          private.bg = "#${mantle}";
          private.fg = "#${subtext1}";
          progress.bg = "#${base}";
          url = {
            error.fg = "#${red}";
            fg = "#${text}";
            hover.fg = "#${sky}";
            success.http.fg = "#${teal}";
            success.https.fg = "#${green}";
            warn.fg = "#${yellow}";
          };
        };
        tabs = {
          bar.bg = "#${crust}";
          even.bg = "#${surface2}";
          even.fg = "#${overlay2}";
          odd.bg = "#${surface1}";
          odd.fg = "#${overlay2}";
          indicator.error = "#${red}";
          indicator.start = "#${blue}";
          indicator.stop = "#${green}";
          pinned.even.bg = "#${base}";
          pinned.even.fg = "#${text}";
          pinned.odd.bg = "#${base}";
          pinned.odd.fg = "#${text}";
          pinned.selected.even.bg = "#${base}";
          pinned.selected.even.fg = "#${teal}";
          pinned.selected.odd.bg = "#${base}";
          pinned.selected.odd.fg = "#${teal}";
          selected.even.bg = "#${base}";
          selected.even.fg = "#${text}";
          selected.odd.bg = "#${base}";
          selected.odd.fg = "#${text}";
        };
      };
    };
    extraConfig = ''
      c.tabs.padding = {"bottom": 10, "left": 10, "right": 10, "top": 10}
    '';
  };
}
