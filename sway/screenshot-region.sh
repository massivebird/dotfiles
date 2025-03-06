#!/usr/bin/env bash

# Prompt user to define screenshot region.
SLURPED="$(slurp)"

grim -g "$SLURPED" "$HOME/Pictures/screenshots/$(date +"%m-%d-%YT%H-%M-%S").png"

# Save screenshot to clipboard.
grim -g "$SLURPED" - | wl-copy

notify-send "Screenshot taken saved: $(date +"%m-%d-%YT%H-%M-%S").png"
