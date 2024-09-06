# !/bin/bash

string=$(pactl info | grep "Default Sink:")

speaker="alsa_output.pci-0000_64_00.6.HiFi__Speaker__sink"
headphone="bluez_output.E8_EE_CC_48_B9_9C.1"

if [[ "$string" == "Default Sink: $speaker" ]]
then
  pactl set-default-sink $headphone
else 
  pactl set-default-sink $speaker
fi
