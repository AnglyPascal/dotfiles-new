# !/bin/bash

good="a2dp-sink-aptx"

string=$(pactl list cards | grep "Active Profile" | tail -1)

if [[ "$string" == *"$good"* ]]
then
  pactl set-card-profile bluez_card.60_F4_3A_A2_5B_B8 headset-head-unit
else 
  pactl set-card-profile bluez_card.60_F4_3A_A2_5B_B8 a2dp-sink-aptx
fi
