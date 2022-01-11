PROJECTS = git rg tmux homebrew zsh macos neovim

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
