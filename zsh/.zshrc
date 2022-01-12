eval "$(starship init zsh)"

if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

if [ -e "$HOME/.cargo/env" ]; then
    source $HOME/.cargo/env
fi

if [ -e "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init - --no-rehash)"
fi

export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export SSH_AUTH_SOCK=/Users/rupertbedford/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

source '/usr/local/opt/fzf/shell/completion.zsh'
source '/usr/local/opt/fzf/shell/key-bindings.zsh'

alias vim=nvim

export CLICOLOR=1

eval "$(gdircolors -b)"

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
