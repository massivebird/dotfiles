#!/usr/bin/env bash

# contains formatted strings relevant
# to displaying generic output

# base colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
GRAY="$(tput setaf 7)"

# reset colors
NC="$(tput sgr 0)"

# status strings
STATUS_CONS="[$GRAY CONS $NC]"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"
