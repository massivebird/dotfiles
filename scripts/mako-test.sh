#!/usr/bin/env bash

# mako-test.sh
# invokes dummy notification
# for mako daemon

if [ -z "$1" ] || [ "$1" == "1" ]; then
   notify-send --urgency normal "Notification Title" "This is the body"
elif [ "$1" == "2" ]; then
   notify-send --urgency critical "URGENT NOTIFICATION" "This is very important"
elif [ "$1" == "3" ]; then
   notify-send --urgency low "This isn't important" "It might as well not exist"
fi
