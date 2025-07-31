{ config, pkgs, nix-flatpak, ... }:

{
  imports = [
    # Import the nix-flatpak module
    nix-flatpak.nixosModules.nix-flatpak
  ];

  # Optional: Add flatpak-specific settings
  services.flatpak.enable = true;
}
