#!/bin/sh

temp_file="/home/ahsan/pictures/temp.png"
perm_file="/home/ahsan/pictures/screenshots/$(date +%s).png"

window_select () {
  maim -u -st 9999999 -B $temp_file
}

full_monitor () {
  maim -u -m 7 $temp_file
}

area_select () {
  maim -u -s -m 7 $temp_file
}

copy_temp() {
  xclip -sel clip -t image/png $temp_file
  mv $temp_file $perm_file
}

while getopts wma flag
do
    case "${flag}" in
        w) window_select;;
        m) full_monitor;;
        a) area_select;;
    esac
done
copy_temp

