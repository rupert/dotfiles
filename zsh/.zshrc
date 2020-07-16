export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

eval "$(direnv hook zsh)"

[ -e "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
