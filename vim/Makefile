VIM_PLUG := $(HOME)/.vim/autoload/plug.vim

install: $(VIM_PLUG)
	brew install vim
	stow -v --ignore Makefile -t $(HOME) .
	vim +PlugUpdate +qall

$(VIM_PLUG):
	mkdir -p $(HOME)/.vim/autoload
	curl -fLo $(VIM_PLUG) https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
