programs := $(shell find . -depth 1 -type d -not -name .git)
vundle := $(HOME)/.vim/bundle/Vundle.vim
pipsi := $(HOME)/.local/bin/pipsi
brew := /usr/local/bin/brew

all: $(programs) vundle-install pipsi-install

sublime-preamble:
	mkdir -p '$(HOME)/Library/Application Support/Sublime Text 3/Packages'

sublime: sublime-preamble

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

macos: brew-bundle apm-install
	pip3 install virtualenv

.PHONY: $(programs)
.SUFFIXES:
