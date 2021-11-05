PROJECTS = git rg tmux vim homebrew vscode zsh macos neovim

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
