#!/usr/bin/env bash
# Launch an app from the bar; focus it instead if it's already open.
case "$1" in
  zen) class="zen"; cmd="$HOME/zen-browser/zen" ;;
  t3)  class="t3"
       cmd=$(command -v t3code || command -v t3-code || command -v T3-Code || true)
       if [ -z "$cmd" ]; then notify-send "T3 Code isn't installed" "Run: yay -S t3code-bin"; exit 0; fi ;;
  grok) class="grok-bot"; cmd="$HOME/Applications/grok-bot.AppImage" ;;
esac
addr=$(hyprctl clients -j | python3 -c "import json,sys;c=[w['address'] for w in json.load(sys.stdin) if '$class' in w['class'].lower()];print(c[0] if c else '')")
if [ -n "$addr" ]; then hyprctl dispatch "hl.dsp.focus({ window = \"address:$addr\" })" >/dev/null
else setsid -f $cmd >/dev/null 2>&1; fi
