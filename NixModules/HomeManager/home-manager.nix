{
  config,
  pkgs,
  inputs,
  #nix-flatpak,
  ...
}:
{

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.wretched_abyss = {
      imports = [
        ../../Hosts/Main/home.nix
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ];
    };

  };
}
