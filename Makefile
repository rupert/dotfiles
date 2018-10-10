UNAME := $(shell sh -c 'uname -s 2>/dev/null || echo other')

PROJECTS = fish git keychain rg tmux vim go-jira pyenv

ifeq ($(UNAME),Darwin)
	PROJECTS += homebrew vscode macos
endif

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
