PROJECTS = git rg tmux homebrew vscode zsh macos neovim

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
