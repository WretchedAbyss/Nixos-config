{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "hyprland";
  };
  services.flatpak = {
    enable = true;
    packages = [
      {
        appId = "com.discordapp.Discord";
        origin = "flathub";
      }
    ];
    overrides = {
      global = {
        # [Metadata keywords](https://docs.flatpak.org/en/latest/flatpak-command-reference.html?highlight=override#flatpak-metadata)
        Context.filesystems = [
          "/nix/store:ro"
        ];
      };
    };
  };

}
