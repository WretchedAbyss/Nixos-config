{
  description = "My NixOS configuration with Discord, Flatpak, Waybar, and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    waybar.url = "github:Alexays/Waybar/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensure Home Manager uses the same nixpkgs version
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-flatpak, waybar, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Adjust to your architecture (e.g., "aarch64-linux" for ARM)
      specialArgs = { inherit nix-flatpak; }; # Pass nix-flatpak to modules
      modules = [
        # Main system configuration
        ./configuration.nix
        # Flatpak module
        ./modules/flatpak.nix
        # Waybar module
        ./modules/waybar.nix
        # Home Manager module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true; # Use system nixpkgs
          home-manager.useUserPackages = true; # Install user packages to ~/.nix-profile
          home-manager.users.wretched_abyss = import ./home.nix; # User-specific configuration
        }
        # Apply overlays
        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            (import ./overlays/waybar-overlay.nix { inherit waybar nixpkgs; })
          ];
        })
      ];
    };
  };
}
