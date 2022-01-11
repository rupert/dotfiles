eval "$(starship init zsh)"

eval "$(direnv hook zsh)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

if [ -e "$HOME/.cargo/env" ]; then
    source $HOME/.cargo/env
fi

if [ -e "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

eval "$(pyenv init --path)"
eval "$(pyenv init - --no-rehash)"

export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

export SSH_AUTH_SOCK=/Users/rupertbedford/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
