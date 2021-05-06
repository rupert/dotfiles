export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    virtualenv
    z
)

source $ZSH/oh-my-zsh.sh

eval "$(direnv hook zsh)"

if [ -e "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
