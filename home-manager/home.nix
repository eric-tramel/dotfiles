{ config, pkgs, lib, xdg, ... }:

let 
  bazel_symlink_bazelisk = pkgs.runCommand "bazel" { } ''
    mkdir -p $out/bin
    ln -s ${pkgs.bazelisk}/bin/bazelisk $out/bin/bazel
  '';

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

  customAwscli2 = pkgs.awscli2.overrideAttrs (oldAttrs: {
    postPatch = ''
      substituteInPlace pyproject.toml \
        --replace-fail 'flit_core>=3.7.1,<3.9.1' 'flit_core>=3.7.1' \
        --replace-fail 'awscrt>=0.19.18,<=0.22.0' 'awscrt>=0.22.0' \
        --replace-fail 'cryptography>=40.0.0,<43.0.2' 'cryptography>=43.0.0' \
        --replace-fail 'distro>=1.5.0,<1.9.0' 'distro>=1.5.0' \
        --replace-fail 'docutils>=0.10,<0.20' 'docutils>=0.10' \
        --replace-fail 'prompt-toolkit>=3.0.24,<3.0.39' 'prompt-toolkit>=3.0.24'
      substituteInPlace requirements-base.txt \
        --replace-fail "wheel==0.43.0" "wheel>=0.43.0"
      # Remove pip requirement as dependencies are provided via PYTHONPATH
      sed -i '/pip>=/d' requirements/bootstrap.txt
    '';
  });

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
    bazel_symlink_bazelisk
    pkgs.bat
    pkgs.zoxide
    pkgs.nerd-fonts.fira-code
    pkgs.fzf
    pkgs.oh-my-zsh
    #pkgs.spaceship-prompt
    pkgs.starship
    pkgs.jq
    pkgs.tree
    pkgs.chezmoi
    pkgs.git
    pkgs.gita
    pkgs.htop
    pkgs.imgcat
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.fd
    pkgs.btop
    pkgs.uv
    pkgs.wget
    pkgs.aerospace
    pkgs.jankyborders
    pkgs.cmake
    pkgs.docker
    pkgs.bazelisk
    pkgs.direnv
    pkgs.kubectl
    pkgs.sentencepiece
    pkgs.tfswitch
    pkgs.rustc
    pkgs.cargo
    pkgs.pyenv
    pkgs.go
    pkgs.ssm-session-manager-plugin
    pkgs.parallel
    pkgs.hyperfine
    pkgs.xz
    pkgs.lazygit

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
      # source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      # autoload -U promptinit; promptinit
      # prompt spaceship

      eval "$(starship init zsh)"

      # Set the direnv init
      eval "$(direnv hook zsh)"

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
    set -g @catppuccin_window_right_separator " "
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

  home.file."${config.xdg.configHome}/borders/bordersrc".text = ''
  #!/bin/bash
  
  options=(
      style=round
      width=4.0
      hidpi=on
      active_color=0xffebbc62
      inactive_color=0xff414550
  )

  borders "''${options[@]}"
  '';

  home.file."${config.xdg.configHome}/aerospace/aerospace.toml".text = ''
  after-startup-command = ['exec-and-forget /Users/eric/.nix-profile/bin/borders']

  start-at-login = true

  default-root-container-layout = 'tiles'
  default-root-container-orientation = 'auto'
  automatically-unhide-macos-hidden-apps = true

  [key-mapping]
  preset = 'qwerty'

  [gaps]
  inner.horizontal = 12
  inner.vertical =   12
  outer.left =       8
  outer.bottom =     8
  outer.top =        8
  outer.right =      8

  [mode.main.binding]
  alt-h = 'focus left'
  alt-j = 'focus down'
  alt-k = 'focus up'
  alt-l = 'focus right'

  alt-shift-h = 'move left'
  alt-shift-j = 'move down'
  alt-shift-k = 'move up'
  alt-shift-l = 'move right'  

  alt-shift-minus = 'resize smart -50'
  alt-shift-equal = 'resize smart +50'


  alt-1 = 'workspace 1'
  alt-2 = 'workspace 2'
  alt-3 = 'workspace 3'
  alt-4 = 'workspace 4'
  alt-5 = 'workspace 5'
  alt-6 = 'workspace 6'
  alt-7 = 'workspace 7'
  alt-8 = 'workspace 8'
  alt-9 = 'workspace 9'

  alt-shift-1 = 'move-node-to-workspace 1'
  alt-shift-2 = 'move-node-to-workspace 2'
  alt-shift-3 = 'move-node-to-workspace 3'
  alt-shift-4 = 'move-node-to-workspace 4'
  alt-shift-5 = 'move-node-to-workspace 5'
  alt-shift-6 = 'move-node-to-workspace 6'
  alt-shift-7 = 'move-node-to-workspace 7'
  alt-shift-8 = 'move-node-to-workspace 8'
  alt-shift-9 = 'move-node-to-workspace 9'

  alt-tab = 'workspace-back-and-forth'

  alt-shift-semicolon = 'mode service'

  [mode.service.binding]
  alt-shift-h = ['join-with left', 'mode main']
  alt-shift-j = ['join-with down', 'mode main']
  alt-shift-k = ['join-with up', 'mode main']
  alt-shift-l = ['join-with right', 'mode main']
  '';

  home.file."${config.xdg.configHome}/ghostty/config".text = ''
  shell-integration = zsh
  title = " "
  macos-titlebar-style = hidden
  macos-titlebar-proxy-icon = hidden
  macos-window-shadow = false
  '';

  home.file."${config.xdg.configHome}/starship.toml".text = ''
  format = """
  $hostname\
  $directory\
  $git_branch\
  $git_state\
  $git_status\
  $line_break\
  $python\
  $character"""

  [directory]
  style = "blue"

  [character]
  success_symbol = "[╰►](blue)"
  error_symbol = "[╰►](red)"
  vimcmd_symbol = "[╰►](green)"

  [git_branch]
  format = "[$branch]($style)"
  style = "bright-black"

  [git_status]
  format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)"
  style = "cyan"
  conflicted = "​"
  untracked = "​"
  modified = "​"
  staged = "​"
  renamed = "​"
  deleted = "​"
  stashed = "≡"

  [git_state]
  format = '\([$state( $progress_current/$progress_total)]($style)\) '
  style = "bright-black"

  [cmd_duration]
  format = "[$duration]($style) "
  style = "yellow"

  [python]
  format = "[$virtualenv]($style) "
  style = "bright-black"
  '';
}
