{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    # Add other user-specific packages here
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
    #bibata-cursors-translucent
    bibata-cursors
    graphite-gtk-theme
    papirus-icon-theme
  ];
  gtk = {
    enable = true;
    font.name = "FiraCode Nerd Font 14"; # Ensures FiraCode Nerd Font for GTK apps
    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
