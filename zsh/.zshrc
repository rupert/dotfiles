function source_if_exists() {
    if [ -e "$1" ]; then
        source "$1" "$@"
    fi
}

eval "$(starship init zsh)"

if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

export PATH="$HOME/.local/bin:$PATH"

source_if_exists "$HOME/.cargo/env"

source_if_exists "$HOME/.zshrc.local"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init - --no-rehash)"
    eval "$(pyenv virtualenv-init -)"
fi

export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh" --no-use
source_if_exists "$NVM_DIR/bash_completion"

case "$OSTYPE" in
    darwin*)
        export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

        export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

        source_if_exists /usr/local/opt/fzf/shell/completion.zsh
        source_if_exists /usr/local/opt/fzf/shell/key-bindings.zsh

        eval "$(gdircolors -b)"
        ;;
    linux*)
        eval "$(dircolors -b)"
        alias ls='ls --color=auto'

        source_if_exists /usr/share/doc/fzf/examples/completion.zsh
        source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
esac

alias vim=nvim

export CLICOLOR=1

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
