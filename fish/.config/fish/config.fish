set fish_greeting ""

set -gx PYTHONPATH ~/Library/Python/3.7/lib/python/site-packages $PYTHONPATH
set -gx PROJECT_HOME ~/Developer
set -gx PATH $PATH ~/.local/bin ~/Library/Python/3.7/bin
set -gx RIPGREP_CONFIG_PATH ~/.config/rg

eval (direnv hook fish)
eval (python3 -m virtualfish auto_activation projects)
