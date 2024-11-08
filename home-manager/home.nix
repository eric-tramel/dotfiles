{ config, pkgs, lib, ... }:

let 
  tmuxPlugins = {
    tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tmux-sessionx";
      version = "unstable-2024-11-04";
      src = pkgs.fetchFromGitHub {
        owner = "omerxx";
        repo = "tmux-sessionx";
        rev = "0711d0374fe0ace8fd8774396469ab34c5fbf360";
        hash = "sha256-9IhXoW9o/ftbhIree+I3vT6r3uNgkZ7cskSyedC3xG4=";
      };
      meta = {
        homepage = "https://github.com/omerxx/tmux-sessionx";
        description = "A Tmux session manager, with preview, fuzzy finding, and MORE";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.unix;
        maintainers = with lib.maintainers; [ omerxx ];
      };
    };

    tmux-floax = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tmux-floax";
      version = "unstable-2024-11-04";
      src = pkgs.fetchFromGitHub {
        owner = "omerxx";
        repo = "tmux-floax";
        rev = "864ceb9372cb496eda704a40bb080846d3883634";
        hash = "sha256-vG8UmqYXk4pCvOjoSBTtYb8iffdImmtgsLwgevTu8pI=";
      };
      meta = {
        homepage = "https://github.com/omerxx/tmux-floax";
        description = "The missing floating pane for Tmux";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.unix;
        maintainers = with lib.maintainers; [ omerxx ];
      };
    };
  };

  catppuccinAlacrittyTheme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "alacritty";
    rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
    hash = "sha256-H8bouVCS46h0DgQ+oYY8JitahQDj0V9p2cOoD4cQX+Q=";
  };

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "eric";
  home.homeDirectory = "/Users/eric";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.hello
    pkgs.bat
    pkgs.zoxide
    pkgs.nerdfonts
    pkgs.fzf
    pkgs.oh-my-zsh
    pkgs.spaceship-prompt
    pkgs.jq
    pkgs.tree
    pkgs.chezmoi
    pkgs.alacritty
    pkgs.gita
    pkgs.uv
    pkgs.htop
    pkgs.imgcat
    pkgs.nodejs
    pkgs.ripgrep

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # Link the Catppuccin Mocha theme file for Alacritty
    ".config/alacritty/themes/catppuccin_mocha.toml".source = "${catppuccinAlacrittyTheme}/catppuccin-mocha.toml";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eric/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    FOO = "bar";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    initExtra = ''
      # Source Spaceship Prompt
      source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      autoload -U promptinit; promptinit
      prompt spaceship
    '';
  };
  
  programs.zoxide = {
    enable = true;
  };

  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "~/.config/alacritty/themes/catppuccin_mocha.toml" ];
      font.size = 12;
      font.normal = {
        family  = "FiraCode Nerd Font Propo";
        style = "Retina";
      };
      font.bold = {
        family  = "FiraCode Nerd Font Propo";
        style = "Bold";
      };
      font.italic = {
        family  = "FiraCode Nerd Font Propo";
        style = "Light";
      };
    };
  };


  programs.tmux = {
    enable = true;
    baseIndex = 1;

    plugins = [
      tmuxPlugins.tmux-floax
      tmuxPlugins.tmux-sessionx
      pkgs.tmuxPlugins.catppuccin
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.tmux-fzf
    ];

    extraConfig = ''
    set-option -g default-terminal 'screen-256color'
    set-option -g terminal-overrides ',xterm-256color:RGB'
    set -g default-command zsh
    set -g detach-on-destroy off
    set -g escape-time 0
    set -g renumber-windows on
    set -g set-clipboard on
    set -g status-position top
    setw -g mode-keys vi
    setw -g automatic-rename on
    setw -g automatic-rename-format "#T"

    # Do some key-bound pane adjusting
    bind -r C-k resize-pane -U
    bind -r C-j resize-pane -D
    bind -r C-h resize-pane -L
    bind -r C-l resize-pane -R

    ## SessionX
    set -g @floax-width '80%'
    set -g @floax-height '80%'
    set -g @floax-border-color 'magenta'
    set -g @floax-text-color 'blue'
    set -g @floax-bind 'p'
    set -g @floax-change-path 'true'

    set -g @sessionx-bind 'o'
    set -g @sessionx-zoxide-mode 'on'

    ## Lovingly lifted from 
    ## https://github.com/omerxx/dotfiles/blob/master/tmux/tmux.conf
    set -g @catppuccin_flavour 'mocha'
    set -g @catppuccin_window_left_separator ""
    set -g @catppuccin_window_right_separator " "
    set -g @catppuccin_window_middle_separator " █"
    set -g @catppuccin_window_number_position "right"
    set -g @catppuccin_window_default_fill "number"
    set -g @catppuccin_window_current_fill "number"
    set -g @catppuccin_window_default_text "#W"
    set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
    set -g @catppuccin_status_modules_right "directory date_time"
    set -g @catppuccin_status_modules_left "session"
    set -g @catppuccin_status_left_separator  " "
    set -g @catppuccin_status_right_separator " "
    set -g @catppuccin_status_right_separator_inverse "no"
    set -g @catppuccin_status_fill "icon"
    set -g @catppuccin_status_connect_separator "no"
    set -g @catppuccin_directory_text "#{b:pane_current_path}"
    set -g @catppuccin_date_time_text "%H:%M"

    run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    run-shell ${tmuxPlugins.tmux-floax}/share/tmux-plugins/tmux-floax/tmux_floax.tmux
    run-shell ${tmuxPlugins.tmux-sessionx}/share/tmux-plugins/tmux-sessionx/tmux_sessionx.tmux
    '';
  };

  programs.git = {
    enable = true;
    userName = "Eric W. Tramel";
    userEmail = "eric.tramel@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.fzf = {
    enable = true;
    defaultCommand = ''
    rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"
    '';
  };

}
