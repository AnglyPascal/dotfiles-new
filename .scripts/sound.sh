#!/bin/bash

speaker="alsa_output.pci-0000_64_00.6.HiFi__Speaker__sink"
headphones=(
  "bluez_output.E8:EE:CC:48:B9:9C"
  "bluez_output.34:09:C9:7D:9C:00"
)

current=$(pactl info | awk '/Default Sink:/ {print $3}')

available=$(pactl list short sinks | awk '{print $2}')

find_available_headphone() {
  for hp in "${headphones[@]}"; do
    if echo "$available" | grep -qx "$hp"; then
      echo "$hp"
      return
    fi
  done
}

if [[ "$current" == "$speaker" ]]; then
  hp=$(find_available_headphone)
  if [[ -n "$hp" ]]; then
    pactl set-default-sink "$hp"
  else
    echo "No headphone sink available" >&2
    exit 1
  fi
else
  pactl set-default-sink "$speaker"
fi
