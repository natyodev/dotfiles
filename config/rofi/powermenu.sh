#!/usr/bin/env bash
# Small forest-themed power menu
choice=$(printf '󰌾  Lock\n󰍃  Log out\n󰒲  Suspend\n󰜉  Reboot\n󰐥  Shut down' | \
  rofi -dmenu -i -p "" -theme-str 'listview { columns: 1; lines: 5; } element { orientation: horizontal; padding: 10px 14px; } window { width: 280px; } inputbar { enabled: false; }')
case "$choice" in
  *Lock)       loginctl lock-session ;;
  *"Log out")  hyprctl dispatch 'hl.dsp.exit()' ;;
  *Suspend)    systemctl suspend ;;
  *Reboot)     systemctl reboot ;;
  *"Shut down") systemctl poweroff ;;
esac
