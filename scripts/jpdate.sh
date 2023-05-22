#!/usr/bin/env bash

# outputs current date in Japanese format

# Sat May 7 -> 5月7日(土)

# kanji representing Sunday to Saturday
kanji=(日 月 火 水 木 金 土)

printf "$(date +%-m)月$(date +%-d)日(${kanji[$(date +%w)]})\n"
