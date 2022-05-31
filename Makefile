PROJECTS = git rg tmux homebrew zsh macos neovim starship

install: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C $@

.PHONY: $(PROJECTS)
