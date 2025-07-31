{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ../../HomeManagerModules/default.nix ];

  # Home Manager needs a bit of information about your user and setup
  home.username = "wretched_abyss";
  home.homeDirectory = "/home/wretched_abyss";

  # Specify the Home Manager release version for compatibility
  home.stateVersion = "24.05"; # Adjust based on your needs (24.05 is compatible with nixos-25.05)

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

}
