#!/usr/bin/env bash

## displays dummy notification for `mako` daemon

# reload configuration
makoctl reload

if [ -z "$1" ] || [ "$1" == "1" ]; then
   notify-send --urgency normal "Urgency: Normal" "Standard notification style"
elif [ "$1" == "2" ]; then
   notify-send --urgency critical "Urgency: Critical" "Very important!"
elif [ "$1" == "3" ]; then
   notify-send --urgency low "Urgency: Low" "Meow! meow meow meow :3"
fi
