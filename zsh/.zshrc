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
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

source_if_exists "$HOME/.cargo/env"

source_if_exists "$HOME/.zshrc.local"

if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init - --no-rehash)"
fi

export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh" --no-use
source_if_exists "$NVM_DIR/bash_completion"

export SSH_AUTH_SOCK=/Users/rupertbedford/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# Darwin
source_if_exists /usr/local/opt/fzf/shell/completion.zsh
source_if_exists /usr/local/opt/fzf/shell/key-bindings.zsh

# Linux
source_if_exists /usr/share/doc/fzf/examples/completion.zsh
source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh

alias vim=nvim

export CLICOLOR=1

if command -v gdircolors &> /dev/null; then
    # Darwin
    eval "$(gdircolors -b)"
else
    # Linux
    eval "$(dircolors -b)"
fi

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
