#!/usr/bin/env bash
# Rebuild this setup on a fresh Arch install.
#   git clone <this repo> ~/dotfiles && ~/dotfiles/install.sh
set -euo pipefail
D="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%F-%H%M%S)"

say() { printf '\n\033[1;32m==> %s\033[0m\n' "$*"; }

link() {  # link <repo path> <target path under $HOME>
  local src="$D/$1" dst="$HOME/$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then rm "$dst"
  elif [ -e "$dst" ]; then mkdir -p "$BACKUP/$(dirname "$2")"; mv "$dst" "$BACKUP/$2"; echo "  backed up ~/$2"
  fi
  ln -s "$src" "$dst"; echo "  linked ~/$2"
}

say "Installing packages (needs your password)"
sudo pacman -Syu --needed - < "$D/packages-repo.txt"

if ! command -v yay >/dev/null; then
  say "Installing yay (AUR helper)"
  tmp=$(mktemp -d); git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
  (cd "$tmp/yay-bin" && makepkg -si --noconfirm); rm -rf "$tmp"
fi
say "Installing AUR packages"
grep -v -E '^yay(-bin)?(-debug)?$' "$D/packages-aur.txt" | yay -S --needed - || true

say "Linking config files"
for p in hypr/hyprland.lua hypr/hyprpaper.conf hypr/scripts waybar rofi nwg-dock-hyprland ghostty; do
  link "config/$p" ".config/$p"
done
link cache/nwg-dock-pinned .cache/nwg-dock-pinned
for f in "$D"/local/share/applications/*.desktop; do
  link "local/share/applications/$(basename "$f")" ".local/share/applications/$(basename "$f")"
done
link home/.zshrc .zshrc
link home/.gitconfig .gitconfig

say "Wallpapers"
mkdir -p "$HOME/Pictures/wallpapers"
cp -n "$D/wallpapers/"* "$HOME/Pictures/wallpapers/" || true
[ -f "$HOME/Pictures/wallpapers/forest.mp4" ] || \
  curl -fL -o "$HOME/Pictures/wallpapers/forest.mp4" \
    https://github.com/Darkkal44/qylock/raw/main/themes/forest/bg.mp4 || echo "  (video download failed; still image will be used)"

say "Neovim config"
[ -d "$HOME/.config/nvim" ] || git clone https://github.com/ecosse3/nvim.git "$HOME/.config/nvim"

say "Zen browser"
[ -x "$HOME/zen-browser/zen" ] || echo "  Zen isn't installed: download the Linux tarball from https://zen-browser.app and extract it to ~/zen-browser"

say "Done. Log out and back in (or reboot) to start Hyprland with this setup."
[ -d "$BACKUP" ] && echo "Old files were moved to $BACKUP"
