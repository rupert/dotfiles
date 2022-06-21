{ config, pkgs, lib, ... }:

{
  home = {
    username = "rupert";
    homeDirectory = "/Users/rupert";

    stateVersion = "22.05";

    packages = with pkgs; [
      bat
      bazelisk
      coreutils-prefixed
      curl
      direnv
      dive
      docker
      fd
      ffmpeg
      gh
      git
      git-lfs
      go
      google-cloud-sdk
      grex
      htop
      hyperfine
      imagemagick
      jq
      kubectl
      kubectx
      nix-info
      nodejs
      openjdk11
      parallel
      poetry
      protobuf
      pwgen
      python39
      python39Packages.pip
      python39Packages.pip-tools
      ripgrep
      roboto
      roboto-mono
      source-code-pro
      sqlite
      tree
      watch
      watchexec
      youtube-dl

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

    lfs.enable = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      format = "$directory$git_branch$git_commit$git_state$git_status$fill$python$kubernetes$command_duration$cmd_duration$line_break$character";

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
        format = "[$symbol$context]($style) ";
        symbol = " ";
        style = "fg:white";
      };

      python = {
        format = "[$symbol$pyenv_prefix($version )(\\($virtualenv\\) )]($style)";
        symbol = " ";
        style = "fg:white";
      };
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
