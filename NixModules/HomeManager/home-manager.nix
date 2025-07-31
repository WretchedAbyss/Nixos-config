{ config, pkgs, inputs, nix-flatpak, ...}: {

        home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.wretched_abyss = {
                        imports = [
                                ../../Hosts/Main/home.nix
                                nix-flatpak.homeManagerModules.nix-flatpak
                        ];
                };

        }; 
}
