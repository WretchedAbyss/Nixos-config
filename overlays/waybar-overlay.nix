{ waybar, nixpkgs }:

self: super: {
  waybar_git = super.callPackage ({ stdenv, lib, fetchFromGitHub, meson, ninja, pkg-config, wayland, libinput, systemd, ... }:
    stdenv.mkDerivation rec {
      pname = "waybar";
      version = "git-${waybar.rev or "unknown"}";

      src = waybar;

      nativeBuildInputs = [ meson ninja pkg-config ];
      buildInputs = [ wayland libinput systemd ];

      mesonFlags = [
        "--prefix=${placeholder "out"}"
        "-Dexperimental=true"
        "-Dsystemd=enabled"
      ];

      meta = with lib; {
        description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
        license = licenses.mit;
        platforms = platforms.linux;
      };
    }) {};
}
