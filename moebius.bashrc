# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=5000
export HISTFILESIZE=5000

# tmux hack http://askubuntu.com/questions/51132/gnome-open-raises-this-error-when-run-from-inside-tmux
# also check ~.tmux.conf for set-option -g update-environment "DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY"
# export DBUS_SESSION_BUS_ADDRESS=$(tr '\0' '\n' < /proc/$(pgrep -U $(whoami) gnome-session)/environ|grep ^DBUS_SESSION_BUS_ADDRESS=|cut -d= -f2-)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the 	 to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PATH=$PATH:/home/moebius/scripts
#export PATH=$PATH:/opt/texbin
export PATH=$PATH:/opt/java/jdk1.7.0_75/bin
export JAVA_HOME=/opt/java/jdk1.7.0_75/

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## git-branch
function set_git_branch {
	git status > /dev/null 2>&1
	if [ $? -lt 128 ]; then
		local branch=$(git branch -a | grep "^\*" | sed s/"^\* "//)
		if [ -n "$branch" ]; then
			if [ "$branch" = "(no branch)" ]; then
				branch=$(git log -1 | head -n1 | cut -c 8-15)
			fi
			local lines=$(git status | grep -c "working directory clean")
			if [ $lines -eq 0 ]; then
				echo "[${branch}]*"
			else
				echo "[${branch}]"
			fi
		fi
	fi
}

if [ "$EUID" != "0" ]; then
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[0;33m\]$(set_git_branch)\[\033[01;34m\] \$\[\033[0m\] '
fi

utf8()
{
    iconv -f ISO-8859-1 -t UTF-8 $1 > $1.tmp
    rm $1
    mv $1.tmp $1
}

function .. (){
  local arg=${1:-1};
  local dir=""
  while [ $arg -gt 0 ]; do
dir="../$dir"
    arg=$(($arg - 1));
  done
cd $dir #>&/dev/null
}

function go (){
  if [ $# == "0" ] || [ $1 == "-h" ]
  then
    echo "Usage: go [(number)] [-l] [-a (path)] [-r (number)] [-h]"
    echo "    (number): cd to stored path with number"
    echo "    -l: list stored bookmarks"
    echo "    -a: store new path to navigate"
    echo "    -s: save current location as bookmark"
    echo "    -r: remove bookmark at given number"
    echo "    -h: show this help"
  elif [ $1 == "-a" ]
  then
    echo $2 >> $HOME/.go_history
    echo `wc -l < $HOME//.go_history`
  elif [ $1 == '-s'  ]
  then
    echo `pwd` >> $HOME/.go_history
    echo `wc -l < $HOME//.go_history`
  elif [ $1 == "-l" ]
  then
    file="$HOME/.go_history"
    i=1
    while read line
    do
      echo $i":"$line
      i=`expr $i + 1`
    done <"$file"
  elif [ $1 == "-r" ]
  then
    sed -i $2'd' $HOME/.go_history
  elif [ $1 == "0" ]
  then
    :
  else
    i=1
    file="$HOME/.go_history"
    while read line
     do
       lines[$i]="$line"
       i=`expr $i + 1`
     done <"$file"
     cd ${lines[$1]}
  fi
}

fn() {
    if test "$#" = 2; then
        find . -iname $1 | head -n $2 | tail -n 1
    elif test "$#" = 1;
    then
        find . -iname $1 | head -n 1
    else
        find . | head -n 1
    fi
}



h() {
    echo "Custom Commands:"
    echo "  .. {n}          ->  go up 1 or n directories"
    echo "  go {n}          ->  go to bookmarked location n"
    echo "  fn (expr) (n)   ->  find expr in current directory and return the n-th result (default: 1st)"
    echo "  ma              ->  show (m)y (a)liases, i.e. mostly short-hands for common commands"
}
