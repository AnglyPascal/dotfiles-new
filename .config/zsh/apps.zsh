# modify the feh start script
alias feh_=/usr/bin/feh
feh(){
  sh $HOME/.config/zsh/feh.sh $@
}

i(){
  if [[ -f $1 ]]
  then
    if [[ -f $2 ]]
    then 
      imv $@ &!
    else
      imv-dir $1 &!
    fi
  else
    imv-dir . &!
  fi
  echo ''
}

# open document files with the appropriate apps
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

# convenience aliases with arguments
mpv(){ /usr/bin/mpv $@ &! }
mpvc(){ /usr/bin/mpv --loop-file=0 $@ &! }
ink(){ inkscape $@ &!  }
fig(){ inkscape --export-area-drawing --export-latex --export-filename="${1%.svg}.pdf" $1 }

# open geog era
ggb(){
  if [[ -f "/home/ahsan/git/atom/figs/$1.ggb" ]]
  then
  else
    cp /home/ahsan/git/atom/figs/main.ggb /home/ahsan/git/atom/figs/$1.ggb
  fi
  geogebra /home/ahsan/git/atom/figs/$1.ggb >/dev/null &!
}

# kill hung sbt processes
killJava () {
  killall -9 /home/ahsan/.jenv/versions/openjdk64-17.0.3/bin/java
}

# legacy
com () {
  ./compile $1; echo ""; ./a.out
}

# compile latex into epub
tex2epub(){
  latexml --dest=$1.xml $1.tex
  latexmlpost -dest=$1.html $1.xml
  ebook-convert $1.html $1.epub --language en --no-default-epub-cover
}

# unzip all into individual folders
uz(){
  for i in *.zip
  do 
    mkdir "${i%.zip}"
    unzip "$i" -d "${i%.zip}"
  done
}

xp_setup(){
  xrandr --output HDMI-1-2 --auto --output eDP-1-1 --auto --left-of HDMI-1-2
  /home/ahsan/.config/polybar/launch.sh
  xp
}

ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

flush () { 
  i=$(($1-1)); 
  while (( $i>=0 )); 
  do 
    copyq read $i >> $2; 
    echo "" >> $2; 
    echo "" >> $2; 
    echo "" >> $2; 
    ((i--)); 
  done 
}

# convert image to b/w
bw () { 
  copyq read image/png 0 > $1.png; 
  convert $1.png -colorspace Gray $1.png 
}

# convert pdf to b/w
bwpdf () {
  pdftk $1 cat ${2}-${2} output $3
  gs \
    -sOutputFile=output.pdf \
    -sDEVICE=pdfwrite \
    -sColorConversionStrategy=Gray \
    -dProcessColorModel=/DeviceGray \
    -dCompatibilityLevel=1.4 \
    -dNOPAUSE \
    -dBATCH \
    $3
  mv output.pdf $3
}


sortImg() {
  python /home/ahsan/git/socialsync/scripts/groupimg.py -f $(pwd) $@
}


### switch between dark and light terminal and nvim themes
toggle_term () {
  ALACRITY_CONFIG="$HOME/.config/alacritty/alacritty.yml"
  if grep -Fq "light.yaml" "$ALACRITY_CONFIG"
  then
      sed -i 's/light\.yaml/dark\.yaml/' "$ALACRITY_CONFIG"
  else
      sed -i 's/dark\.yaml/light\.yaml/' "$ALACRITY_CONFIG"
  fi
}

toggle_nvim () {
  NVIM_CONFIG="$HOME/.config/nvim/init.lua"
  if grep -Fq "bestwhite" "$NVIM_CONFIG"
  then
      sed -i 's/bestwhite/bestblack/' "$NVIM_CONFIG"
  else
      sed -i 's/bestblack/bestwhite/' "$NVIM_CONFIG"
  fi
}

switch () {
  toggle_term
  toggle_nvim
}

mega(){
  HOME=$(pwd)
  megasync &!
  HOME=/home/ahsan
}
