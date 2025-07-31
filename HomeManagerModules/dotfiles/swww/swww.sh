#!/bin/bash

# Path to the wallpapers directory
wallpapersDir="$HOME/Pictures/WallPapers"

while true; do
  # Get a random image file from the directory
  selectedWallpaper=$(find "$wallpapersDir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

  # Check if a wallpaper was found
  if [ -n "$selectedWallpaper" ]; then
    # Set the wallpaper using swww
    swww img "$selectedWallpaper" --resize crop --transition-type random --transition-fps 60
    # Generate and apply Wallust colors
    wallust run "$selectedWallpaper"
    killall .waybar-wrapped
    waybar &
  else
    echo "No images found in $wallpapersDir"
  fi

  # Wait for 2 hours (7200 seconds)
  sleep 7200
done
