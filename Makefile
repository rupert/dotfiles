UNAME := $(shell sh -c 'uname -s 2>/dev/null || echo other')

PROJECTS = fish git rg tmux vim go-jira pyenv homebrew vscode

install: $(PROJECTS)

fish: pyenv

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
