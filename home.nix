{ config, pkgs, lib,... }:

{
  # Home Manager needs a bit of information about your user and setup
  home.username = "wretched_abyss";
  home.homeDirectory = "/home/wretched_abyss";

  # Specify the Home Manager release version for compatibility
  home.stateVersion = "24.05"; # Adjust based on your needs (24.05 is compatible with nixos-25.05)

  # User-specific packages
  home.packages = with pkgs; [
    #firefox
    #vim
    git
    # Add other user-specific packages here
  ];

  # Example: Manage Waybar configuration for the user
  xdg.configFile."waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;

  # Tofi Config
  xdg.configFile."tofi/config".source = ./dotfiles/tofi/config;

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;


  programs.git = {
  enable = true;
  userEmail = "AlecJamesFowler@protonmail.com";
  userName = "WretchedAbyss";
  };
  programs.zsh = {
    enable = true;
    
    shellAliases = {
      ll = "ls -l";
      cd = "z";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos";
    };
    history.size = 10000;
  };
  programs.zoxide = {
  enable = true;
  enableZshIntegration = true;
  enableBashIntegration = true; # Add this for Bash
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true; # Enable Zsh integration
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    settings = {
      shell = "${pkgs.zsh}/bin/zsh"; # Set Zsh as the default shell
    };
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
