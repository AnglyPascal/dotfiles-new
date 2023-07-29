#!/bin/bash

killall -p polybar
# polybar mybar >>/tmp/polybar1.log 2>&1 & disown
# polybar HDMI >>/tmp/polybar1.log 2>&1 & disown

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config.ini
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m ML=$XDG_CURRENT_DESKTOP polybar --reload mybar &
  done
else
  polybar mybar &
fi
