# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wretched_abyss = {
    isNormalUser = true;
    description = "Alec J Fowler";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaPersistenced = true;

  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # Enable sound with PipeWire
  security.rtkit.enable = true; # Required for PipeWire to manage real-time scheduling
  services.pipewire = {
    enable = true;
    alsa.enable = true; # Enable ALSA support for compatibility
    alsa.support32Bit = true; # Useful for 32-bit applications
    pulse.enable = true; # Enable PulseAudio compatibility
   };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.greetd.enable = true;
  programs.regreet.enable = true;

  #Enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #programs.zsh.enable = true;

  environment.sessionVariables = {
    #
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
   };
  services.displayManager.defaultSession = "hyprland";
  # Enabled FlatPaks
  services.flatpak.enable = true;
  services.flatpak.packages = [
    { appId = "com.discordapp.Discord"; origin = "flathub"; }
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Text Editors
  neovim
  vscodium

  # Web Browsers
  brave

  # Terminal and Shell Utilities
  kitty          # Terminal emulator
  #zoxide         # Smart cd command
  fzf            # Fuzzy finder
  tofi           # Launcher/menu

  # File and Archive Management
  yazi           # File manager
  file           # File type identification
  p7zip          # Archive utility
  fd             # File finder
  ripgrep        # Fast grep alternative

  # Media and Graphics
  ffmpeg         # Multimedia processing
  imagemagick    # Image manipulation
  resvg          # SVG rendering
  grim           # Screenshot utility (Wayland)
  slurp          # Region selector (Wayland)
  swww           # Desktop Background Management
  playerctl      # Media Player Control
  dunst          # Notification Daemon
  wl-clipboard   # Wayland ClipBoard
  brightnessctl  # Brightness Control

  # Audio Control
  pavucontrol    # Audio control GUI
  pamixer        # Audio mixer CLI

  # System Monitoring and Management
  btop           # System monitor
  psmisc         # Process utilities
  home-manager   # User environment management
  lm_sensors     # Hardware Temp Data
  nvtopPackages.nvidia          # Nvidia GPU Monitor
  upower         # Battery Status


  # Package Management
  flatpak        # Flatpak application support

  # Data Processing and Formatting
  jq             # JSON processor
  poppler        # PDF rendering

  # Fonts
  nerd-fonts.symbols-only  # Symbol fonts
  nerd-fonts.fira-code
  # Networking
  wget           # File downloader
  git            # git manager
  curl           # API fetching for Weather and Scripts
  networkmanager # Network management
  blueman        # Bluetooth manager
  starship       # Customized Prompt

  # Miscellaneous
  pastel         # Color manipulation
  astroterm      # Terminal-based astronomy tool
  sl             # Novelty (steam locomotive animation)
];

  programs.git = {
    enable = true;
    config = {
      user.name = "WretchedAbyss";
      user.email = "alec9north@gmail.com";
      safe.directory = "/etc/nixos"; # Mark /etc/nixos as safe for Git
    };
  };
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host github.com
        User git
        IdentityFile /etc/ssh/ssh_host_ed25519_key
        AddKeysToAgent yes
    '';
    };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
