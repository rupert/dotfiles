export PATH=~/.local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

[ -z "$PS1" ] && return

[ -e /etc/bashrc ] && . /etc/bashrc
[ -e /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export HISTCONTROL=ignorespace:ignoredups
export HISTTIMEFORMAT='%F %T '
export HISTFILESIZE=
export HISTSIZE=

export CLICOLOR=1
export EDITOR=vim
export PYTHONDONTWRITEBYTECODE=1
export TERM=xterm-256color
export LESS=FRSX
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export HOMEBREW_GITHUB_API_TOKEN=7d1753d57a9fc920f4ab9db590ea8934eb1d06a6
export GCAL='--cc-holidays=gb_en'

export PROMPT_DIRTRIM=3
export GIT_PS1_SHOWDIRTYSTATE=1

set_prompt() {
  local status=$?
  local red='\[\e[01;31m\]'
  local green='\[\e[01;32m\]'
  local blue='\[\e[01;34m\]'
  local white='\[\e[01;37m\]'
  local reset='\[\e[00m\]'

  PS1="$white\\h$reset $blue\\w$reset "

  if command -v __git_ps1 &> /dev/null; then
    PS1+="$white$(__git_ps1 "%s ")$reset"
  fi

  if [ $status -eq 0 ]; then
    PS1+="$white\\\$$reset "
  else
    PS1+="$red\\\$$reset "
  fi
}

PROMPT_COMMAND='set_prompt'

if [ `uname` == "Darwin" ]; then
  eval `keychain --eval --quiet --agents ssh --inherit any id_rsa`
else
  eval `keychain --eval --quiet --agents ssh id_rsa`
fi

alias diff=colordiff
alias ack=ag
alias brew='nice brew'
