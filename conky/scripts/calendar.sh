#!/bin/sh

gcalcli --conky agenda today |
    sed -e 's/color black/color0/g' \
	-e 's/color red/color4/g' \
	-e 's/color green/color7/g' \
	-e 's/color yellow/color6/g' \
	-e 's/color blue/color2/g' \
	-e 's/color magenta/color8/g' \
	-e 's/color cyan/color/g' \
	-e 's/color brightred/color5/g' \
	-e 's/color white/color/g'

