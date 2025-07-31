{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    #Programing Languages and Tools
    gcc
    python3
    nodejs
    rustc
    cargo
    clang-tools
    unzip
    nixfmt-rfc-style
    #NuShell Plugins
    nushellPlugins.formats
    nushellPlugins.net
    nushellPlugins.skim
    #nushellPlugins.dbus
    nushellPlugins.units
    nushellPlugins.highlight
    nushellPlugins.polars
    nushellPlugins.semver
    nushellPlugins.gstat
    nushellPlugins.query
    (writeScriptBin "nvim-nix" ''
      #!/bin/sh
      nix run ~/Nixos#nvim --no-write-lock-file "$@"
    '')
  ];

  home.sessionVariables = {
    EDITOR = "nvim-nix";
    VISUAL = "nvim-nix";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      cd = "z";
      rebuild = "sudo nixos-rebuild switch --flake ~/Nixos/#nixos";
    };
    history.size = 10000;

  };
  programs.nushell = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      cd = "z";
      rebuild = "sudo nixos-rebuild switch --flake ~/Nixos/#nixos";
      cat = "bat";
      vim = "nix run ~/Nixos#nvim --no-write-lock-file";
      vi = "nix run ~/Nixos#nvim --no-write-lock-file";
      nvim = "nix run ~/Nixos#nvim --no-write-lock-file";
    };
    plugins = with pkgs.nushellPlugins; [
      formats
      net
      skim
      #dbus
      units
      highlight
      polars
      semver
      gstat
      query
    ];
    extraEnv = ''
      $env.EDITOR = "nvim-nix"
      $env.VISUAL = "nvim-nix"
      $env.SUDO_EDITOR = "nvim-nix"
    '';
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true; # Add this for Bash
    enableNushellIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false; # Single-line prompt
      scan_timeout = 30; # Default from preset
      format = lib.concatStrings [
        "$os"
        "$username"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$battery"
        "$character"
      ];

      # Simple palette inspired by Nerd Font Symbols
      palette = "simple";
      palettes.simple = {
        blue = "#458588";
        green = "#98971a";
        red = "#cc241d";
        yellow = "#d79921";
        purple = "#b16286";
        white = "#ebdbb2";
        black = "#282828";
      };

      # OS module (platform-specific icons)
      os = {
        disabled = false;
        format = "[$symbol]($style)";
        style = "bold blue";
        symbols = {
          Arch = "󰣇 ";
          Debian = "󰣚 ";
          Fedora = "󰣹 ";
          Linux = "󰌽 ";
          Macos = "󰀵 ";
          NixOS = "󱄅 ";
          Ubuntu = "󰕈 ";
          Unknown = "󰟶 ";
        };
      };

      # Username module
      username = {
        style_user = "bold white";
        style_root = "bold red";
        format = "[$user]($style) ";
        show_always = false; # Show only for SSH/root
      };

      # Directory module (works with zoxide)
      directory = {
        style = "bold blue";
        truncation_length = 3;
        truncate_to_repo = true;
        truncation_symbol = "…/";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        read_only = " 🔒";
        read_only_style = "red";
      };

      # Git branch module
      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };

      # Git state module
      git_state = {
        format = "[\($state( $progress_current/$progress_total)\)]($style) ";
        style = "bold yellow";
      };

      # Git status module
      git_status = {
        format = "([$all_status$ahead_behind]($style)) ";
        style = "bold yellow";
        conflicted = "⚠️ ";
        ahead = "⇡ ";
        behind = "⇣ ";
        diverged = "⇕ ";
        untracked = "★ ";
        stashed = "📍 ";
        modified = "✎ ";
        staged = "✔ ";
        deleted = "✖ ";
      };

      # Command duration module
      cmd_duration = {
        min_time = 2000; # Show if >2s
        format = "[$duration]($style) ";
        style = "bold yellow";
      };

      # Jobs module
      jobs = {
        symbol = "✦";
        style = "bold blue";
        number_threshold = 1;
        format = "[$symbol$number]($style) ";
      };

      # Battery module
      battery = {
        full_symbol = "󱈑 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰁾 ";
        empty_symbol = "󰂎 ";
        format = "[$symbol$percentage]($style) ";
        style = "bold red";
      };

      # Character module
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vicmd_symbol = "[V](bold blue)"; # For Zsh vi-mode
      };
    };
  };

}
