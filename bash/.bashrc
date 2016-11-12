export PATH=~/.local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

[ -z "$PS1" ] && return

[ -e /etc/bashrc ] && . /etc/bashrc
[ -e /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export HISTCONTROL=ignorespace:ignoredups
export HISTTIMEFORMAT='%F %T '
export HISTFILESIZE=
export HISTSIZE=

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export PYTHONDONTWRITEBYTECODE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

export PROMPT_DIRTRIM=3
export GIT_PS1_SHOWDIRTYSTATE=1

export CLICOLOR=1
export EDITOR=vim
export TERM=xterm-256color
export LESS=FRSX
export HOMEBREW_GITHUB_API_TOKEN=7d1753d57a9fc920f4ab9db590ea8934eb1d06a6
export GCAL='--cc-holidays=gb_en'

prompt_git() {
  if command -v __git_ps1 &> /dev/null; then
    echo -n "$(__git_ps1 ' \033[34m%s\033[37m')"
  fi
}

prompt_virtualenv() {
  [ -z "$VIRTUAL_ENV" ] && return 0

  echo -n ' '
  echo -n $'\033[33m'
  echo -n "$(basename "$VIRTUAL_ENV")"
  echo -n $'\033[37m'
}

prompt_user() {
  [ "$USER" == 'rupert' ] && return
  [ "$USER" == 'rupert.bedford' ] && return

  if [ $(id -u) == '0' ]; then
    echo -n $'\033[31m'
  else
    echo -n $'\033[35m'
  fi

  echo -n "$USER"
  echo -n $'\033[37m'
  echo -n ' '
}

EXIT_CODE=0

prompt_command() {
  EXIT_CODE=$?
}

prompt_exit() {
  if [ $EXIT_CODE != 0 ]; then
    echo -n ' '
    echo -n $'\033[31m'
    echo -n "($EXIT_CODE)"
    echo -n $'\033[37m'
  fi
}

export PS1='\n$(prompt_user)\e[36m\h\e[37m \e[32m\w\e[37m$(prompt_virtualenv)$(prompt_git)$(prompt_exit)\n\$ '

PROMPT_COMMAND=prompt_command

if [ $(uname) == Darwin ]; then
  eval $(keychain --eval --quiet --agents ssh --inherit any id_rsa)
else
  eval $(keychain --eval --quiet --agents ssh id_rsa)
fi

alias diff=colordiff
alias ack=ag
alias git=hub
alias python=python3
