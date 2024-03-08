# !/bin/bash

# alsa_output=$(pactl list sinks short | awk -F ' ' '{print $2}' | grep "alsa_output" | grep "Generic_1" | head -1)
alsa_output=$(pactl list sinks | grep "Description: Family" -B1 | grep "Name" | awk -F ': ' '{print $2}')
bluez_output=$(pactl list sinks short | awk -F ' ' '{print $2}' | grep "bluez_output" | head -1)

string=$(pactl info | grep "Default Sink:")

if [[ "$string" == "Default Sink: $alsa_output" ]]
then
  pactl set-default-sink $bluez_output
else 
  pactl set-default-sink $alsa_output
fi
