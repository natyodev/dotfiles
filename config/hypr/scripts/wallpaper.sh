#!/usr/bin/env bash
# Animated wallpaper if mpvpaper is installed, otherwise the still frame.
VIDEO="$HOME/Pictures/wallpapers/forest.mp4"
STILL="$HOME/Pictures/wallpapers/forest.png"

pkill -x mpvpaper; pkill -x hyprpaper

if command -v mpvpaper >/dev/null && [ -f "$VIDEO" ]; then
  # -p: pause automatically when windows fully cover the wallpaper (saves battery)
  exec mpvpaper -p -o "no-audio loop hwdec=auto panscan=1.0" ALL "$VIDEO"
else
  exec hyprpaper
fi
