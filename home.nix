{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    (self: super: {
      python39 = super.python39.override {
        packageOverrides = pself: psuper: {
          pyopenssl = psuper.pyopenssl.overrideAttrs (old: {
            meta = with old; {
              inherit meta;
              broken = false;
            };
          });
        };
      };
      python310 = super.python310.override {
        packageOverrides = pself: psuper: {
          pyopenssl = psuper.pyopenssl.overrideAttrs (old: {
            meta = with old; {
              inherit meta;
              broken = false;
            };
          });
        };
      };
    })
  ];

  home = {
    username = "rupert";
    homeDirectory = "/Users/rupert";

    stateVersion = "22.05";

    packages = with pkgs; [
      age
      alejandra
      coreutils-prefixed
      curl
      difftastic
      dive
      docker
      docker-compose
      exiftool
      fd
      ffmpeg
      google-cloud-sdk
      grex
      hledger
      hledger-interest
      htmlq
      hyperfine
      imagemagick
      jq
      kubectl
      kubectx
      kubeseal
      nix-index
      nix-info
      nixpkgs-fmt
      nodejs
      openjdk11
      parallel
      pgcli
      protobuf
      postgresql
      pwgen
      python39
      redis
      ripgrep
      roboto
      roboto-mono
      sd
      shellcheck
      source-code-pro
      sqlite-interactive
      tree
      watch
      watchexec
      youtube-dl
      zstd

      (nerdfonts.override {
        fonts = ["FiraCode"];
      })

      (import ./kubefwd.nix {})
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

    shellAliases =
      {
        lg = "lazygit";
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        ls = "ls --color=auto";
      };

    sessionPath = [
      "$HOME/.poetry/bin"
      "$HOME/.local/bin"
      "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
    ];
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

    lfs.enable = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      format = "$directory$git_branch$git_commit$git_state$git_status$fill( $python)( $kubernetes)( $cmd_duration)$line_break$character";

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

    initExtra = ''
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

      function venv() {
        python -m venv .venv --upgrade-deps
        .venv/bin/pip install --upgrade wheel
        echo ". .venv/bin/activate" >> .envrc
      }
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
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
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

    extraConfig = ''
      IdentityAgent /Users/rupert/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    '';
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
