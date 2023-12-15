# !/bin/bash

alsa_output=$(pactl list sinks short | awk -F ' ' '{print $2}' | grep "alsa_output")
bluez_output=$(pactl list sinks short | awk -F ' ' '{print $2}' | grep "bluez_output")

string=$(pactl info | grep "Default Sink:")

if [[ "$string" == "Default Sink: $alsa_output" ]]
then
  pactl set-default-sink $bluez_output
else 
  pactl set-default-sink $alsa_output
fi
