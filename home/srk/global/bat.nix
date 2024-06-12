{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    config = {
      # Don't set it for now cause man pages are broken if not used with default theme;
      # So I setup fish to alias bat = bat --theme mocha when reading a file bat when using man it will use default
      # theme which works for man pages
      # theme = "mocha";
    };
    themes = {
      mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };
}
