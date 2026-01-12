{
  pkgs,
  lib,
  ...
}:
{
  home = {
    username = "rupert";
    homeDirectory = "/Users/rupert";

    stateVersion = "22.05";

    packages = with pkgs; [
      age
      alejandra
      awscli2
      bash
      black
      coreutils-prefixed
      curl
      difftastic
      dive
      docker
      docker-compose
      exiftool
      fd
      ffmpeg
      grex
      hledger
      hledger-interest
      htmlq
      hyperfine
      imagemagick
      inetutils
      jq
      nerd-fonts.fira-code
      netlify-cli
      nil
      nix-index
      nix-info
      nixpkgs-fmt
      nodejs_22
      openjdk17
      parallel
      pnpm
      postgresql
      protobuf
      pwgen
      redis
      ripgrep
      roboto
      roboto-mono
      sd
      shellcheck
      source-code-pro
      sqlite-interactive
      ssm-session-manager-plugin
      tree
      watch
      watchexec
      zstd

      (python312.withPackages (python-pkgs: [
        python-pkgs.pip
      ]))

      (pulumi.withPackages (pulumi-pkgs: [
        pulumi-pkgs.pulumi-nodejs
      ]))
    ];

    sessionVariables =
      {
        CLICOLOR = "1";
        EDITOR = "nvim";
        RESTIC_PASSWORD_COMMAND = "security find-generic-password -s restic -w";
      }
      // (lib.mkIf pkgs.stdenv.isDarwin {
        SSH_AUTH_SOCK = "$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      });

    shellAliases =
      {
        lg = "lazygit";
      }
      // (lib.mkIf pkgs.stdenv.isLinux {
        ls = "ls --color=auto";
      });

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.npm/bin"
    ];

    file.".sqliterc".text = ''
      .mode table
    '';

    file.".npmrc".text = ''
      prefix=~/.npm
    '';

    activation = {
      installClaudeCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        npm install --global --quiet @anthropic-ai/claude-code
      '';
    };
  };

  programs.bat.enable = true;
  programs.dircolors.enable = true;
  programs.fzf.enable = true;
  programs.gh.enable = true;
  programs.go.enable = true;
  programs.home-manager.enable = true;
  programs.htop.enable = true;
  programs.lazygit.enable = true;
  programs.zoxide.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;

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

    settings = {
      alias = {
        ap = "add --patch";
        cm = "commit --message";
        ds = "diff --staged";
        st = "status --short --branch";
        undo = "reset --soft HEAD~";
        up = "!git fetch && git rebase --autostash FETCH_HEAD";
      };

      branch.autosetuprebase = "always";

      color.ui = true;
      core.editor = "nvim";
      credential.helper = "osxkeychain";

      diff = {
        renames = "copies";
        colorMoved = "default";
      };

      fetch.prune = true;
      help.autocorrect = 1;
      merge.conflictstyle = "diff3";
      pull.rebase = true;

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      submodule.recurse = true;

      user = {
        name = "Rupert Bedford";
        email = "182958+rupert@users.noreply.github.com";
      };
    };

    lfs.enable = true;
  };

  programs.delta = {
    enable = true;
    options.navigate = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      format = "$directory$git_branch$git_commit$git_state$git_status$fill( $python)( $kubernetes)( $aws)( $cmd_duration)$line_break$character";

      cmd_duration = {
        format = "[$duration]($style)";
        style = "fg:white bold";
      };

      gcloud.disabled = true;

      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        symbol = " ";
      };

      fill = {
        symbol = " ";
      };

      kubernetes = {
        disabled = false;
        format = "[$context]($style)";
        style = "fg:blue";
      };

      python = {
        format = "[$version( \\($virtualenv\\))]($style)";
        style = "fg:yellow";
        version_format = "\${raw}";
      };
    };
  };

  programs.zsh = {
    enable = true;

    defaultKeymap = "emacs";

    initContent = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-colors "''\${(s.:.)LS_COLORS}"

      bindkey -s '^[3' '#'

      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[3~' delete-char

      autoload -U up-line-or-beginning-search
      zle -N up-line-or-beginning-search
      bindkey '^[[A' up-line-or-beginning-search

      autoload -U down-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey '^[[B' down-line-or-beginning-search

      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^X^E" edit-command-line

      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

      # TODO sessionPath does not work in VS Code integrated terminal
      export PATH="$HOME/.npm/bin:$PATH"
    '';

    envExtra = ''
      if [ -e "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
      fi

      export FZF_DEFAULT_COMMAND='fd --type file --color always'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_CTRL_T_OPTS='--ansi --preview "bat --color always --style plain --theme ansi {}" --bind shift-up:preview-page-up,shift-down:preview-page-down'
    '';

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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

      imap <silent> <M-3> #

      autocmd BufRead * autocmd FileType <buffer> ++once
        \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
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

  programs.ssh = {
    enable = true;

    matchBlocks."*" = {
      identityAgent = "/Users/rupert/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      setEnv = {
        TERM = "xterm-256color";
      };
    };
  };

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

      KeyRepeat = 2;
      InitialKeyRepeat = 15;
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
