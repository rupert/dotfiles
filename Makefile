programs := $(shell find . -depth 1 -type d -not -name .git)
vim_plug := $(HOME)/.vim/autoload/plug.vim
pipsi := $(HOME)/.local/bin/pipsi

all: $(programs) vim-plug-install pipsi-install

sublime-preinstall:
	mkdir -p '$(HOME)/Library/Application Support/Sublime Text 3/Packages'
	mkdir -p '$(HOME)/.local/bin'
	ln -sf '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' '$(HOME)/.local/bin/subl'

sublime: sublime-preinstall

keychain-preinstall:
	mkdir -p '$(HOME)/.local/bin'

keychain: keychain-preinstall

$(programs):
	stow -v --ignore '\.example$$' -t $(HOME) $@

$(vim_plug):
	mkdir -p $(HOME)/.vim/autoload
	curl -fLo $(vim_plug) https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim-plug: $(vim_plug)

vim-plug-install: vim-plug
	vim +PlugInstall +qall

vim-plug-update: vim-plug
	vim +PlugUpdate +qall

$(pipsi):
	curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python

pipsi: $(pipsi)

pipsi-install: pipsi
	sh pipsi.sh

brew-bundle:
	brew tap homebrew/bundle
	brew bundle

macos: brew-bundle

.PHONY: $(programs)
.SUFFIXES:
