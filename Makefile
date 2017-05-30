programs := $(shell find . -depth 1 -type d -not -name .git)
vundle := $(HOME)/.vim/bundle/Vundle.vim
pipsi := $(HOME)/.local/bin/pipsi

all: $(programs) vundle-install pipsi-install

sublime-preinstall:
	mkdir -p '$(HOME)/Library/Application Support/Sublime Text 3/Packages'
	mkdir -p '$(HOME)/.local/bin'
	ln -sf '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' '$(HOME)/.local/bin/subl'

sublime: sublime-preinstall

keychain-preinstall:
	mkdir -p '$(HOME)/.local/bin'

keychain: keychain-preinstall

pyenv-preinstall:
	mkdir -p '$(HOME)/.pyenv'

pyenv: pyenv-preinstall

$(programs):
	stow -v --ignore '\.example$$' -t $(HOME) $@

$(vundle):
	mkdir -p $(HOME)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $@

vundle: $(vundle)

vundle-install: vundle
	vim +PluginInstall +qall

vundle-update: vundle
	vim +PluginUpdate +qall

brew-bundle:
	brew tap homebrew/bundle
	brew bundle

$(pipsi):
	curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python

pipsi: $(pipsi)

pipsi-install: pipsi
	sh pipsi.sh

macos: brew-bundle

.PHONY: $(programs)
.SUFFIXES:
