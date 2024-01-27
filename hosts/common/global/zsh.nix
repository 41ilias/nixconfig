{
  # Zsh configured with home manager but is better to have it also on a OS level
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };

  # HomeManager recomendatio to enable completions for system packages
  environment.pathsToLink = [ "/share/zsh" ];
}
