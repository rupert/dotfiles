UNAME := $(shell sh -c 'uname -s 2>/dev/null || echo other')

PROJECTS = fish git keychain rg tmux vim go-jira

ifeq ($(UNAME),Darwin)
	PROJECTS += homebrew vscode
endif

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
