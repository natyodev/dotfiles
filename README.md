# nato's dotfiles

Arch Linux + Hyprland (Lua config, 0.55+) with a forest-green theme.

| Piece | What | Config |
|---|---|---|
| Window manager | Hyprland | `config/hypr/hyprland.lua` |
| Wallpaper | animated forest (mpvpaper), still fallback (hyprpaper) | `config/hypr/scripts/wallpaper.sh` |
| Left bar | Waybar, Quiet-Fracture layout | `config/waybar/` |
| Bottom dock | nwg-dock-hyprland (auto-hide, right-click to pin) | `config/nwg-dock-hyprland/`, `cache/nwg-dock-pinned` |
| Launcher + power menu | rofi | `config/rofi/` |
| Terminal | Ghostty | `config/ghostty/` |

## New machine

```sh
git clone <repo-url> ~/dotfiles
~/dotfiles/install.sh
```

## How it works

The files in `~/.config/...` are symlinks into this folder, so edits are saved here automatically.
After changing things, commit them:

```sh
cd ~/dotfiles && git add -A && git commit -m "describe the change"
```

Refresh the package lists after installing new software:

```sh
pacman -Qqen > ~/dotfiles/packages-repo.txt
pacman -Qqem > ~/dotfiles/packages-aur.txt
```

## Keybinds

| Keys | Action |
|---|---|
| Super + Q | Ghostty |
| Super + B | Zen browser |
| Super + E | Dolphin (files) |
| Super + D | App launcher |
| Super + Tab | Show/hide dock |
| Super + C | Close window |
| Super + F | Fullscreen |
| Super + V | Toggle floating |
| Super + H/J/K/L | Move focus |
| Super + 1-9 | Switch workspace |
| Super + Shift + 1-9 | Move window to workspace |
| Super + S / Shift+S | Screenshot region / window |
| Super + W | Restart Waybar |
| Super + Shift + M | Exit Hyprland |
