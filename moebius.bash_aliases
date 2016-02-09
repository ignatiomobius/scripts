# h = show bash helper commands (e.g., go fn, ma)
# convenience commands
alias c='clear'
alias cl='c;l'
alias ct='cd; clear'
alias cg='clear; go'
alias duh='du -lh --max-depth=1'
alias d0='du -lh --max-depth=0'
alias t='tmux'
alias e='evince'
alias v='vim'
alias f='find . -iname'
alias p='plantuml'
alias u='uptime'
alias s='scale-display'
alias m='mkdir'

# ls
alias l='ls -1 -A'
alias ll='ls -1 -A | less'
alias lsg='ls | grep'
alias ag='grep -rnw . -e'

#git
alias gf="git fetch"
alias gfa="git fetch --all"
alias gp="git pull"
alias gph="git push origin HEAD"
alias gphf="git push origin HEAD --force-with-lease"
alias g="git status"
alias gc="git commit -m"
alias gca="git commit --amend"
alias ga="git add -A"
alias gmt="git mergetool"
alias gcf="git clean -f"
alias grc="git rebase --continue"
alias gback="git reset --hard HEAD"
alias gl="git log"
alias gd="git diff"
alias gdcached='git diff --cached'
alias qa="qgit --all &"
alias gb="git branch"
alias gdel="git branch -D"

#settings
alias br="vim ~/.bashrc"
alias brc="gedit ~/.bashrc &"
alias ba="vim ~/.bash_aliases"
alias bu="source ~/.bashrc && source ~/.bash_aliases"
alias ma="less ~/.bash_aliases"

