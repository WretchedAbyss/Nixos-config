#!/bin/sh
WALLPAPER="$1"
wallust run "$WALLPAPER"
killall waybar
waybar &

