set fish_greeting ""

set -x PYTHONPATH ~/Library/Python/3.7/lib/python/site-packages $PYTHONPATH
set -x PROJECT_HOME ~/Developer
set -x PATH $PATH ~/.cargo/bin ~/.local/bin ~/Library/Python/3.7/bin ~/Developer/dotfiles/scripts
set -x RIPGREP_CONFIG_PATH ~/.config/rg

alias chrome "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

eval (direnv hook fish)
eval (/usr/local/bin/python3 -m virtualfish auto_activation projects)

set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
pyenv rehash
