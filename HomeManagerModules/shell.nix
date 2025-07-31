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
  };

}
