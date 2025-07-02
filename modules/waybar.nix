{ config, pkgs, lib, ... }:

{
  # Enable Waybar and add it to system packages
  environment.systemPackages = with pkgs; [
    waybar # Custom Waybar package from overlay
  ];

  # Optional: Enable Waybar as a program (useful for systemd integration)
  programs.waybar = {
    enable = true;
    package = pkgs.waybar; # Use the custom waybar_git package
  };
  # Optional: Enable font for icons (e.g., for battery/network icons)
  fonts.packages = with pkgs; [
    font-awesome # Provides icons for Waybar
  ];
}
