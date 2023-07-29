# !/bin/bash

string=$(pactl info | grep "Default Sink:")

if [[ "$string" == "Default Sink: alsa_output.pci-0000_00_1f.3.analog-stereo" ]]
then
  echo "haha"
  # pactl set-default-sink bluez_output.60_F4_3A_A2_5B_B8.a2dp-sink
  pactl set-default-sink bluez_output.E8_EE_CC_48_B9_9C.a2dp-sink
else 
  pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
fi
