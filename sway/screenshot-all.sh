#!/usr/bin/env bash

grim "$HOME/Pictures/screenshots/$(date +"%m-%d-%YT%H-%M-%S").png"

# Save screenshot to clipboard.
grim - | wl-copy

notify-send "Screenshot taken saved: $(date +"%m-%d-%YT%H-%M-%S").png"
