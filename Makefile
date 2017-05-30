programs := $(shell find . -depth 1 -type d -not -name .git)
vundle := $(HOME)/.vim/bundle/Vundle.vim
pipsi := $(HOME)/.local/bin/pipsi

all: $(programs) vundle-install pipsi-install

sublime-preamble:
	mkdir -p '$(HOME)/Library/Application Support/Sublime Text 3/Packages'
	mkdir -p '$(HOME)/.local/bin'
	ln -sf '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' '$(HOME)/.local/bin/subl'

sublime: sublime-preamble

keychain-preamble:
	mkdir -p '$(HOME)/.local/bin'

keychain: keychain-preamble

pyenv-preamble:
	mkdir -p '$(HOME)/.pyenv'

pyenv: pyenv-preamble

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
	pip3 install virtualenv

.PHONY: $(programs)
.SUFFIXES:
