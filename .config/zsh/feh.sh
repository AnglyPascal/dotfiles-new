#!/bin/sh

if [[ -f $1 ]]
then
  if [[ -f $2 ]]
  then 
    /usr/bin/feh --image-bg black --geometry 800x700 --scale-down -Z $@ &!
  else
    /usr/bin/feh --image-bg black --geometry 800x700 --scale-down -Z --start-at $1 &!
  fi
else
  /usr/bin/feh --image-bg black --geometry 800x700 --scale-down -Z $@ &!
fi
echo ''
