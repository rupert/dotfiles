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
export VIRTUALENV_PYTHON="$(which python3)"
export WORKON_HOME=~/envs
export VIRTUALENVWRAPPER_PYTHON=~/.local/venvs/virtualenvwrapper/bin/python
[ -e ~/.local/bin/virtualenvwrapper.sh ] && . ~/.local/bin/virtualenvwrapper.sh

export JAVA_HOME="$(/usr/libexec/java_home)"

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
    echo -n "$(__git_ps1 ' \001\033[0;34m\002%s\001\033[0m\002')"
  fi
}

prompt_virtualenv() {
  [ -z "$VIRTUAL_ENV" ] && return 0

  echo -n ' '
  echo -ne '\001\033[0;33m\002'
  echo -n "$(basename "$VIRTUAL_ENV")"
  echo -ne '\001\033[0m\002'
}

prompt_user() {
  [ "$USER" == 'rupert' ] && return 0
  [ "$USER" == 'rupert.bedford' ] && return 0

  if [ $(id -u) == '0' ]; then
    echo -ne '\001\033[0;31m\002'
  else
    echo -ne '\001\033[0;35m\002'
  fi

  echo -n "$USER"
  echo -ne '\001\033[0m\002'
  echo -n ' '
}

EXIT_CODE=0

prompt_command() {
  EXIT_CODE=$?
}

prompt_exit() {
  if [ $EXIT_CODE != 0 ]; then
    echo -n ' '
    echo -ne '\001\033[0;31m\002'
    echo -n "($EXIT_CODE)"
    echo -ne '\001\033[0m\002'
  fi
}

export PS1='\[\033[0;32m\]\w\[\033[0m\]$(prompt_virtualenv)$(prompt_git)$(prompt_exit) \$ '

PROMPT_COMMAND=prompt_command

if [ $(uname) == Darwin ]; then
  eval $(keychain --eval --quiet --agents ssh --inherit any id_rsa)
else
  eval $(keychain --eval --quiet --agents ssh id_rsa)
fi

alias diff=colordiff
alias ack=ag
alias git=hub
alias g=git

eval "$(pyenv init -)"
