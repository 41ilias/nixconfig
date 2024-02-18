{ config, pkgs, ... }:

{

  programs.alacritty = {
    enable = true;

    settings = {
      
      env = {
        TERM = "alacritty";
      };
      
      window = {
        padding = {
          x = 10;
          y = 10;
        };

        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };
      
      font = {
        size = 13.0;

        normal = {
          family = "FiraCode Nerd Font";
          style =  "Regular ";
        };
              
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
         
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      
        bold_italic = {
          family = "FiraCode Nerd Font";
          style = "Bold Italic";
        };
      };
      
      colors = {
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          dim_foreground = "#CDD6F4";
          bright_foreground = "#CDD6F4";
        };
      
        normal = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };

        bright = {
          black = "#585B70";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#A6ADC8";
        };

        cursor = {
          cursor = "#F5E0DC";
          text = "#1E1E2E";
        };

        vi_mode_cursor = {
          text = "#1E1E2E";
          cursor = "#B4BEFE";
        };
        
        search.matches = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };
        
        search.focused_match = {
          foreground = "#1E1E2E";
          background = "#A6E3A1";
        };
        
        footer_bar = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };
        
        hints.start = {
          foreground = "#1E1E2E";
          background = "#F9E2AF";
        };
        
        hints.end = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };
        
        selection = {
          text = "#1E1E2E";
          background = "#F5E0DC";
        };
        
        dim = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };
      
        indexed_colors = [
          { index = 16; color = "#FAB387"; }
          { index = 17; color = "#F5E0DC"; }
        ];
      };
    };
  };
}
