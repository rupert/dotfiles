UNAME := $(shell sh -c 'uname -s 2>/dev/null || echo other')

PROJECTS = fish git keychain rg tmux vim go-jira pyenv homebrew vscode macos

fish: pyenv

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
