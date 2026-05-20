#!/bin/zsh

feh_opts=(-D -1 --image-bg black --geometry 800x700 --scale-down -Z)

if [[ -f "$1" && ! -f "$2" ]]; then
  /usr/bin/feh "${feh_opts[@]}" --start-at "$1" &|
else
  /usr/bin/feh "${feh_opts[@]}" "$@" &|
fi
