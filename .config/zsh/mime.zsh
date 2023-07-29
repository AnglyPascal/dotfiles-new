
mime () {
  local mpv = $(which mpv)
  local zathura = $(which zathura)
  local feh = $(which feh) 
  local calibre = $(which ebook-viewer)
  local mcomix = $(which mcomix)

}




z (){ 
  if [[ "$1" == *.(pdf|djvu) ]]
  then
    zathura "$1" &!  
  elif [[ "$1" == *.epub ]]
  then
    ebook-viewer "$1" &!
  elif [[ "$1" == *.(zip|cbz|rar|cbr) ]]
  then
    mcomix "$1" &!
  else
    echo "$1"
  fi
}
