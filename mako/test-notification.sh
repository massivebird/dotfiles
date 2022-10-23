#!/usr/bin/env bash

# test-notification.sh
# invokes dummy notification
# for mako daemon

if [ -z "$1" ] || [ "$1" == "1" ]; then
   notify-send "Notification Title" "This is the body"
elif [ "$1" == "2" ]; then
   notify-send -i "$HOME/Pictures/seag/SEAG (2).jpg" \
      "Notification Title" \
      "With an image, even"
fi
