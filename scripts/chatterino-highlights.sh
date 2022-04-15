#!/usr/bin/env bash

## CHATTERINO-HIGHLIGHTS.SH
# Takes a list of space-separated strings
# and makes a large regex expression
# that matches all of them w/ "or" logic

INP="""
parrotflakes parrot perry pierre peppermint peru parrto peritot perdu periwinkle perimeter perineum parrots perrit passepartout parot puertorico parlayed purry parrrot praotot parsley parsnip paroot parru porrat parrotski sepowski Pavarotti parror parrty pattor porrot parro parruu Parrotsteakes chickenflakes parrpt parruto parroto badmacrobirb aprrot parrotwinkle pbaka pebbermint parrowinkle parur apprt paavarotti parrut prutt patrro prrot parrru parrbt parruru parruparru padbu parrout paurr paparru papagaio parrupan papaur parrit paparu pariiwinkle parron parotr shagaru pparu pypo birbeque parr prrato parvel perriwinkle pawwot parski partu parrof piro pierrot psrru pbrrot birdshavings puro poru pirru pilsk perru parto paparotto pervo parou parpo paraben parruwu parrowo partot parrat paru purrbot perrat pparru pawwu padu pertot pareot parri parroot poopiflakes pastebin
"""

# String manipulations
echo $INP | \
	# Remove leading/trailing whitespace
	sed -E 's/^\ *|\ *$//' | \
	# Turns spaces into booleans
	sed 's/\ /|/g'
