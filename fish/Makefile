install:
	brew install python3
	python3 -m pip install --user virtualfish
	mkdir -p $(HOME)/.config/fish
	mkdir -p $(HOME)/.local/bin
	mkdir -p $(HOME)/.cargo/bin
	mkdir -p $(HOME)/Library/Python/3.7/bin
	stow -v --ignore Makefile -t $(HOME) .
