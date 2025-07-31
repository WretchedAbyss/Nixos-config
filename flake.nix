{
  description = "My NixOS configuration with Discord, Flatpak, Waybar, and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensure Home Manager uses the same nixpkgs version
    };
    nvf.url = "github:notashelf/nvf";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nix-flatpak,
      home-manager,
      nvf,
      sops-nix,
      ...
    }@inputs:
    {

      packages."x86_64-linux" = {
        nvim =
          (nvf.lib.neovimConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            modules = [ ./NixModules/nvf-configuration.nix ];
          }).neovim;
      };
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Adjust to your architecture (e.g., "aarch64-linux" for ARM)
        specialArgs = {
          inherit inputs;
        }; # Pass nix-flatpak to modules
        modules = [
          # Main system configuration
          ./Hosts/Main/configuration.nix
          sops-nix.nixosModules.sops

          home-manager.nixosModules.home-manager

          ./NixModules

          # NVF (Neovim config)
          nvf.nixosModules.default

        ];
      };
    };
}
