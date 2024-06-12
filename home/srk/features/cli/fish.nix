{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;

  hasEza = hasPackage "eza";
  hasTrashy = hasPackage "trashy";
  hasKitty = hasPackage "kitty";
  hasMacchina = hasPackage "macchina";
  hasBat = hasPackage "bat";
in

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      rm = mkIf hasTrashy "trash put";

      ls = mkIf hasEza "eza";
      tree = mkIf hasEza "eza --tree";

      neofetch = mkIf hasMacchina "macchina";
      ftch = mkIf hasMacchina "macchina";

      ssh = mkIf hasKitty "kitty +kitten ssh";

      man = mkIf hasBat "batman";
    };

    shellAliases = {
      bat = "bat --theme mocha";
    };

    interactiveShellInit =
      # Deactivate greeting 
      ''
        set fish_greeting ""
        set MANPAGER "sh -c 'col -bx | bat -l man -p'"
      ''+

      # keybindings
      # \cY by default is yank (but since Ctrl Shift C works too, then I remap it to accept-autosuggestion)
      ''
        bind -M insert \cN complete
        bind -M insert \cP complete-and-search
        bind -M insert \cY accept-autosuggestion
      '' +
      # TODO: look more in depth into this why ctrl+shift+p y doens't work? (Kitty should be able to open files)
      # kitty integration
      ''
        set --global KITTY_INSTALLATION_DIR "${pkgs.kitty}/lib/kitty"
        set --global KITTY_SHELL_INTEGRATION enabled
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
      '' +
      # Use vim bindings and cursors
      ''
        fish_vi_key_bindings
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block
      '' +
      # Use terminal colors
      ''
        set -U fish_color_autosuggestion      brblack
        set -U fish_color_cancel              -r
        set -U fish_color_command             brgreen
        set -U fish_color_comment             brmagenta
        set -U fish_color_cwd                 green
        set -U fish_color_cwd_root            red
        set -U fish_color_end                 brmagenta
        set -U fish_color_error               brred
        set -U fish_color_escape              brcyan
        set -U fish_color_history_current     --bold
        set -U fish_color_host                normal
        set -U fish_color_match               --background=brblue
        set -U fish_color_normal              normal
        set -U fish_color_operator            cyan
        set -U fish_color_param               brblue
        set -U fish_color_quote               yellow
        set -U fish_color_redirection         bryellow
        set -U fish_color_search_match        'bryellow' '--background=brblack'
        set -U fish_color_selection           'white' '--bold' '--background=brblack'
        set -U fish_color_status              red
        set -U fish_color_user                brgreen
        set -U fish_color_valid_path          --underline
        set -U fish_pager_color_completion    normal
        set -U fish_pager_color_description   yellow
        set -U fish_pager_color_prefix        'white' '--bold' '--underline'
        set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      '';
  };
}
