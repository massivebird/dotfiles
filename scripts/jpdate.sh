#!/usr/bin/env bash

## jpdate.sh
# Outputs current date in Japanese format
# Ex: Sat May 7 -> 5月7日(土)
#
# Written for waybar

# kanji representing Sunday to Saturday
kanji=(日 月 火 水 木 金 土)

# output string
printf "$(date +%-m)月$(date +%-d)日(${kanji[$(date +%w)]})\n"
