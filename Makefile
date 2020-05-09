PROJECTS = fish git rg tmux vim go-jira homebrew vscode zsh

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
