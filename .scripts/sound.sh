# !/bin/bash

string=$(pactl info | grep "Default Sink:")

speaker="alsa_output.pci-0000_64_00.6.HiFi__Speaker__sink"
headphone="bluez_output.E8:EE:CC:48:B9:9C"

if [[ "$string" == "Default Sink: $speaker" ]]
then
  pactl set-default-sink $headphone
else 
  pactl set-default-sink $speaker
fi
