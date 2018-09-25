set fish_greeting ""

set -gx PYTHONPATH ~/Library/Python/3.7/lib/python/site-packages $PYTHONPATH
set -gx PROJECT_HOME ~/Developer
set -gx PATH $PATH ~/.cargo/bin ~/.local/bin ~/Library/Python/3.7/bin ~/Developer/dotfiles/scripts
set -gx RIPGREP_CONFIG_PATH ~/.config/rg

alias chrome "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

eval (direnv hook fish)
eval (/usr/local/bin/python3 -m virtualfish auto_activation projects)

set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
pyenv rehash
