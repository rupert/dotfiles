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
