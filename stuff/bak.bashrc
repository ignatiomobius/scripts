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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

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

# If this is an xterm set the title to user@host:dir
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

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias lsg='ls | grep'
# exit typo alias
alias eixt="exit"
# some mvn aliases
alias mci="mvn clean install"
alias mcio="mvn clean install -o"
alias mee="mvn eclipse:clean eclipse:eclipse"
alias meeo="mvn eclipse:clean eclipse:eclipse -o"
alias mcis="mvn clean install -Dmaven.test.skip=true"
alias mcios="mvn clean install -Dmaven.test.skip=true -o"
alias mciee="mvn eclipse:clean clean install eclipse:eclipse"
alias mcieeo="mvn eclipse:clean clean install eclipse:eclipse -o"
alias mcieeos="mvn eclipse:clean clean install eclipse:eclipse -o -Dmaven.test.skip=true -o"
alias gph="git push origin HEAD"
alias gst="git status"
alias qa="qgit --all &"
alias gcm="git commit -m"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PATH=$PATH:/home/moebius/workspace/scripts

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

function .. (){
  local arg=${1:-1};
  local dir=""
  while [ $arg -gt 0 ]; do
dir="../$dir"
    arg=$(($arg - 1));
  done
cd $dir #>&/dev/null
}
