PROJECTS = fish git rg tmux vim go-jira homebrew vscode

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
