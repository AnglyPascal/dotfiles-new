Cp(){
  g++ -o "$1" "$1.cpp"
  ./"$i"
}

tex2epub(){
  latexml --dest=$1.xml $1.tex
  latexmlpost -dest=$1.html $1.xml
  ebook-convert $1.html $1.epub --language en --no-default-epub-cover
}

epdf(){
  pdftk "$1" cat "$2" output "$2.pdf"
}

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

ex ()
{
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

record (){
  gst-launch-1.0  -e pulsesrc device=alsa_input.pci-0000_00_1f.3.analog-stereo \
    ! queue \
    ! audioresample ! audioconvert \
    ! audio/x-raw,rate=44100,channels=2 ! lamemp3enc name=enc target=0 quality=2 \
    ! filesink location=${1-test}.mp3
}

scalatest (){
  scalac $1
  scala -cp $CLASSPATH org.scalatest.run ${1%.scala}
}

j (){
  javac $1
  java $@
}

l2e () {
  latexml --dest=$1.xml $1.tex
  latexmlpost -dest=$1.html $1.xml
  ebook-convert $1.html $1.epub --language en --no-default-epub-cover
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

bw () { 
  copyq read image/png 0 > $1.png; 
  convert $1.png -colorspace Gray $1.png 
}

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

cbzAll() {
  for i in */; do zip "${i%/}".cbz -r "$i"; done
}

sortImg() {
  python /home/ahsan/git/socialsync/scripts/groupimg.py -f $(pwd) $@
}

syncDate() {
 sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.co.uk 2>&1 | sed -n 's/^ *Date: *//p')"
}
