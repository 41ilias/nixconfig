{ config, lib, ... }:
let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;

  hasExa = hasPackage "eza";

in
{
  programs.zsh = {
    enable = true;

    zsh-abbr = {
      enable = true;
      abbreviations = {
        ls = mkIf hasExa "eza";
      };
    };

    dotDir = ".config/zsh";
    defaultKeymap = "viins";

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };

    autocd = true;
    cdpath = [
      "~/projects"
    ];

    history = {
      path = ".config/zsh/zsh_history";
      save = 50000;
      size = 50000;
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    # 
    completionInit = ''
      autoload -Uz compinit
      zstyle ''\':completion:*''\' menu yes select
      zstyle ':completion:*' matcher-list ''\'''\' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zmodload zsh/complist
      _comp_options+=(globdots)		# Include hidden files.
      zle_highlight=('paste:none')
      for dump in ".config/zsh/.zcompdump"(N.mh+24); do
        compinit
      done
      compinit -C
    '';

    initExtra = ''
      unsetopt BEEP
      setopt GLOB_DOTS
      setopt NOMATCH
      setopt MENU_COMPLETE
      setopt EXTENDED_GLOB
      setopt INTERACTIVE_COMMENTS
      setopt APPEND_HISTORY
      setopt BANG_HIST
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_VERIFY

      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      autoload -Uz colors && colors

      zstyle ''\':completion:*''\' menu select

      bindkey -v
      export KEYTIMEOUT=25

      # Use vim keys in tab complete menu:
      if [[ -o menucomplete ]]; then 
          bindkey -M menuselect '^h' vi-backward-char
          bindkey -M menuselect '^k' vi-up-line-or-history
          bindkey -M menuselect '^p' vi-up-line-or-history
          bindkey -M menuselect '^l' vi-forward-char
          bindkey -M menuselect '^j' vi-down-line-or-history
          bindkey -M menuselect '^n' vi-down-line-or-history
          bindkey -M menuselect '^[[Z' vi-up-line-or-history
      fi

      bindkey -v '^?' backward-delete-char

      # Add text objects for quotes and brackets.
      autoload -Uz select-bracketed select-quoted
      zle -N select-quoted
      zle -N select-bracketed
      for m in viopp visual; do
          for c in {a,i}{\',\",\`}; do
              bindkey -M $m -- $c select-quoted
          done
          for c in {a,i}''\${(s..)^:-'()[]{}<>bB'}; do
              bindkey -M $m -- $c select-bracketed
          done
      done

      # Add surround like commands.
      autoload -Uz surround
      zle -N delete-surround surround
      zle -N add-surround surround
      zle -N change-surround surround
      bindkey -M vicmd cs change-surround
      bindkey -M vicmd ds delete-surround
      bindkey -M vicmd ys add-surround
      bindkey -M visual S add-surround
      # escape back into normal mode
      if [[ -n "''\${VI_MODE_ESC_INSERT}" ]] then
          bindkey -M viins "''\${VI_MODE_ESC_INSERT}" vi-cmd-mode
      fi
    '';

    envExtra = ''
      export KEYID="0x81183E9449CCADDF"
    '';
  };
}
