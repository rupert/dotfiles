PROJECTS = git rg tmux vim go-jira homebrew vscode zsh task

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
