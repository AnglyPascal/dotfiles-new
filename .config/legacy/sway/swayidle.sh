#!/bin/env bash
swayidle timeout 270 "~/.config/swaylock/lock.sh 50" \
  timeout 300 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "~/.config/swaylock/lock.sh 50" &

