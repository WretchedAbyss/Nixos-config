{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    git
    sops
  ];
  programs.git = {
    enable = true;
    #userEmail = builtins.readFile "/run/secrets/git/email";
    #userName = builtins.readFile "/run/secrets/git/userName";
  };
  home.activation.setGitConfig = {
    after = [ "writeBoundary" ]; # Run after Home Manager writes files
    before = [ ];
    data = ''
      # Ensure ~/.gitconfig is writable by creating it if it doesn't exist
      touch /home/wretched_abyss/.gitconfig
      chmod u+w /home/wretched_abyss/.gitconfig
      # Set Git config using explicit path to ~/.gitconfig
      /run/current-system/sw/bin/git config --file /home/wretched_abyss/.gitconfig user.email "$(cat /run/secrets/git/email)"
      /run/current-system/sw/bin/git config --file /home/wretched_abyss/.gitconfig user.name "$(cat /run/secrets/git/userName)"
    '';
  };
}
