{
  config,
  pkgs,
  lib,
  ...
}:

{

  # kitty config
  # xdg.configFile."kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  # Waybar config
  xdg.configFile."waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;
  xdg.configFile."waybar/weather.sh" = {
    source = pkgs.writeShellScript "weather.sh" ''
      #!/usr/bin/env bash
      ${builtins.readFile ./dotfiles/waybar/weather.sh}
    '';
    executable = true; # Ensures the script is executable
  };
  # Tofi Config
  xdg.configFile."tofi/config".source = ./dotfiles/tofi/config;
  # Yazi Config
  xdg.configFile."yazi/yazi.toml".source = ./dotfiles/yazi/yazi.toml;
  xdg.configFile."yazi/theme.toml".source = ./dotfiles/yazi/theme.toml;
  # Hyprland Config
  xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
  # Discord Overide
  #home.file.".local/share/flatpak/overrides/com.discordapp.Discord".source =
  #./dotfiles/flatpak/overrides/com.discordapp.Discord;
  # SWWW Script and Config
  xdg.configFile."swww/swww.sh" = {
    source = pkgs.writeShellScript "swww.sh" ''
      #!/usr/bin/env bash
      ${builtins.readFile ./dotfiles/swww/swww.sh}
    '';
    executable = true;
  };
  # Wallust
  xdg.configFile."wallust/wallust.toml".source = ./dotfiles/wallust/wallust.toml;
  xdg.configFile."wallust/templates/colors.css".source = ./dotfiles/wallust/templates/colors.css;
  xdg.configFile."wallust/apply-colors.sh" = {
    source = pkgs.writeShellScript "apply-color.sh" ''
      #!/usr/bin/env bash
      ${builtins.readFile ./dotfiles/wallust/apply-colors.sh}
    '';
    executable = true;
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true; # Enable Zsh integration
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    settings = {
      shell = "${pkgs.nushell}/bin/nu"; # Set Nushell as the default shell
    };
  };
}
