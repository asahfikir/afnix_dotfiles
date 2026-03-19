#!/usr/bin/env bash
# Usage: theme-switch.sh path/to/wallpaper.jpg
WALLPAPER=$1

if [ -z "$WALLPAPER" ]; then
    echo "Usage: theme-switch.sh <path-to-image>"
    exit 1
fi

# 1. Copy wallpaper to a standard location (Optional, but good for "current" wallpaper tracking)
mkdir -p ~/Pictures/Wallpapers
cp "$WALLPAPER" ~/Pictures/Wallpapers/current.jpg

# 2. Run Matugen
# This reads the template, calculates colors, and writes config.kdl
matugen image "$WALLPAPER" --config ~/.config/matugen/config.toml

# 3. Change the Wallpaper
swww img "$WALLPAPER"

echo "Theme applied!"

