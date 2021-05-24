PROJECTS = git rg tmux vim homebrew vscode zsh macos

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
