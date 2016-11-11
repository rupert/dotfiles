programs := $(shell find . -depth 1 -type d -not -name .git)
vundle := $(HOME)/.vim/bundle/Vundle.vim

all: $(programs) vundle-plugins

$(programs):
	stow -v -t $(HOME) $@

$(vundle):
	mkdir -p $(HOME)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $@

vundle: $(vundle)

vundle-plugins: vundle
	vim +PluginInstall +qall

.PHONY: $(programs)
