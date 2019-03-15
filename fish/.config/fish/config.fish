set fish_greeting ""

set -x PYTHONPATH ~/Library/Python/3.7/lib/python/site-packages $PYTHONPATH
set -x PROJECT_HOME ~/Developer
set -x PATH ~/.cargo/bin ~/.local/bin ~/Library/Python/3.7/bin ~/Developer/dotfiles/scripts $PATH
set -x RIPGREP_CONFIG_PATH ~/.config/rg

alias kc kubectx

set -x PATH $HOME/.pyenv/shims $PATH
pyenv rehash
eval (python3 -m virtualfish auto_activation projects)

direnv hook fish | source
