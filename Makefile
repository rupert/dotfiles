PROJECTS = git rg tmux vim homebrew vscode zsh

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
