{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/wretched_abyss/.config/sops/age/keys.txt";
  sops.secrets."git/email" = {
    owner = "wretched_abyss";
    mode = "0400";
  };
  sops.secrets."git/userName" = {
    owner = "wretched_abyss";
    mode = "0400";
  };
  sops.secrets."weather/location" = {
    owner = "wretched_abyss";
  };

}
