install:
	# https://github.com/pyenv/pyenv/issues/1219#issuecomment-428305417
	brew install pyenv
	pyenv install --skip-existing 3.6.8
	pyenv install --skip-existing 3.7.3
	mkdir -p $(HOME)/.pyenv
	stow -v --ignore Makefile -t $(HOME) .
