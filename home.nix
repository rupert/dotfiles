{ config, pkgs, lib, ... }:

{
  home = {
    username = "rupert";
    homeDirectory = "/Users/rupert";

    stateVersion = "22.05";

    packages = with pkgs; [
      bat
      coreutils-prefixed
      direnv
      fd
      gh
      go
      google-cloud-sdk
      grex
      kubectl
      nix-info
      pwgen
      python3
      ripgrep
      tree
    ];

    sessionVariables =
      {
        CLICOLOR = "1";
	      EDITOR = "nvim";
        RESTIC_PASSWORD_COMMAND = "security find-generic-password -s restic -w";
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        SSH_AUTH_SOCK = "$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      };

    shellAliases = lib.optionalAttrs pkgs.stdenv.isLinux {
      ls = "ls --color=auto";
    };

    sessionPath = [
      "$HOME/.poetry/bin"
      "$HOME/.local/bin"
      "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
    ];
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.fzf.enable = true;

  programs.git = {    
    enable = true;

    aliases = {
      ap = "add --patch";
      cm = "commit --message";
      ds = "diff --staged";
      st = "status --short --branch";
      undo = "reset --soft HEAD~";
      up = "!git fetch && git rebase --autostash FETCH_HEAD";
    };

    ignores = 
      # Source: https://gist.github.com/octocat/9257657
      [
        "*.com"
        "*.class"
        "*.dll"
        "*.exe"
        "*.o"
        "*.so"
        "*.7z"
        "*.dmg"
        "*.gz"
        "*.iso"
        "*.jar"
        "*.rar"
        "*.tar"
        "*.zip"
        "*.log"
        "*.sql"
        "*.sqlite"
        ".DS_Store"
        ".DS_Store?"
        "._*"
        ".Spotlight-V100"
        ".Trashes"
        "ehthumbs.db"
        "Thumbs.db"
      ]
      ++ [
        ".vscode"
        ".venv"
        ".pytest_cache"
        ".mypy_cache"
        "__pycache__"
        "*.swp"
        ".envrc"
      ];

    userName = "Rupert Bedford";
    userEmail = "182958+rupert@users.noreply.github.com";

    delta = {
      enable = true;
      options.navigate = true;
    };

    extraConfig = {
      core.editor = "nvim";

      diff = {
        renames = "copies";
        colorMoved = "default";
      };

      credential.helper = "osxkeychain";
      branch.autosetuprebase = "always";
      color.ui = true;
      submodule.recurse = true;
      pull.rebase = true;
      fetch.prune = true;
      merge.conflictstyle = "diff3";
      help.autocorrect = 1;
      push.default = "simple";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      format = "$character";
      right_format = "$all";

      kubernetes = {
        disabled = false;
        format = "[$symbol$context]($style) in ";
      };

      gcloud.disabled = true;
    };
  };

  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    initExtra =
      lib.optionalString pkgs.stdenv.isDarwin ''
        eval "$(gdircolors -b)"
      ''
      + lib.optionalString pkgs.stdenv.isLinux ''
        eval "$(dircolors -b)"
      ''
      + ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''\${(s.:.)LS_COLORS}"
      '';

    envExtra = ''
      if [ -e "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
      fi
    '';
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      tokyonight-nvim
      plenary-nvim
      vim-nix
    ];

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      colorscheme tokyonight

      let mapleader = " "

      nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
      nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
      nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
      nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
    '';
  };

  programs.tmux = {
    enable = true;

    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";

    extraConfig = ''
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };

  programs.zoxide.enable = true;

  xdg.configFile.rg.text = ''
    --line-number
    --no-heading
  '';

  targets.darwin.defaults = {
    NSGlobalDomain = {
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    com.apple.dock = {
      tilesize = 48;
      minimize-to-application = true;
    };

    com.apple.desktopservices = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
  };
}
