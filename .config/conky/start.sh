#!/bin/bash

killall conky
sleep 5s
		
/usr/bin/feh --bg-fill $HOME/.config/conky/imgs/merry.png &> /dev/null &
conky -c $HOME/.config/conky/status.conf &> /dev/null &
conky -c $HOME/.config/conky/clock.conf &> /dev/null &
conky -c $HOME/.config/conky/calendar.conf &> /dev/null &

exit
