VIM_PLUG := $(HOME)/.vim/autoload/plug.vim

$(VIM_PLUG):
	mkdir -p $(HOME)/.vim/autoload
	curl -fLo $(VIM_PLUG) https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install: $(VIM_PLUG)
	stow -v --ignore Makefile -t $(HOME) .
	vim +PlugUpdate +qall
