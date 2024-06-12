fd -tf --color=always . $HOME | fzf --ansi --multi --preview='./file_previewer.sh {}' --bind='enter:execute(nohup xdg-open {} >/dev/null 2>&1 &)+abort'
