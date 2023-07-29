#!/bin/bash

raw=$(acpi -b | cut -f 5 -d " ")
percentage=${raw%\%}

if [[ $percentage > 20 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO"
fi
