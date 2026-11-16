#!/usr/bin/env bash
# Still wallpaper via hyprpaper (see ~/.config/hypr/hyprpaper.conf).
# The old animated (mpvpaper) version is in git history: git show 9a523df:config/hypr/scripts/wallpaper.sh
pkill -x mpvpaper; pkill -x hyprpaper
exec hyprpaper
