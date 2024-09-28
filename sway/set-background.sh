#!/usr/bin/env bash

IMAGE_PATH="$HOME/sway-background-image"
FALLBACK_COLOR="#0e0e0e"

if [ -f "$IMAGE_PATH" ]; then
   swaymsg output "*" bg "$IMAGE_PATH" fill
else
   swaymsg output "*" bg "$FALLBACK_COLOR" solid_color
fi
