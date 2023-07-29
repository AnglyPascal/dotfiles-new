#!/bin/sh
# dlinks

getlinks() { 
	lynx -dump -listonly -nonumbers -nomargins "$*"
}

url=$(getlinks "$*" | dmenu -l 10 -p "URL?")
[ -z "$url" ] && exit

echo $url
