eval "$(starship init zsh)"

eval "$(direnv hook zsh)"

export PATH="$HOME/.local/bin:$PATH"

source $HOME/.cargo/env

if [ -e "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
