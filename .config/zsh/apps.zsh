alias q='exit'
alias rm='rm -v'
alias rr='rm -r'
alias du='du -h'
alias c='clear'
alias rgh='history|rg'

alias cp="cp -i"
alias df='df -h'
alias free='free -m'

alias wo='nmcli device connect wlp3s0'
alias xp='sudo pkill Pentablet_Drive; sudo /home/ahsan/git/dotfiles/xp_pen/Pentablet_Driver.sh'

alias ls='ls -X --group-directories-first --color=auto'
alias ll='ls -alF'
alias la='ls -XA --group-directories-first --color=auto'
alias ld='ls -d */'
alias lc='ls --hide="*.class" --hide="*.out"'
alias math='cd /home/ahsan/git/main/; vim main.tex'

alias oxcs='ssh ug21maam@ecs.ox.ac.uk'

feh(){
  if [[ -f $1 ]]
  then
    if [[ -f $2 ]]
    then 
      /usr/bin/feh --image-bg black --geometry 800x700 --scale-down -Z $@ &!
    else
      /usr/bin/feh --image-bg black --geometry 800x700 --scale-down -Z --start-at $1 &!
    fi
  else
    /usr/bin/feh --image-bg black --geometry 800x700 --scale-down -Z $@ &!
  fi
  echo ''
}

alias musicbee='wine "$wine/Program Files (x86)/MusicBee/MusicBee.exe"'
alias kate='QT_IM_MODULE=ibus kate &!'
alias tg="telegram-desktop QT_IM_MODULE=ibus &!"
alias r='ranger'
alias fm='dolphin ./ &!'

alias yt='noglob yt-dlp'
alias yv='noglob yt-dlp -o "%(title)s.%(ext)s"'
alias ym='noglob yt-dlp --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

alias wss="sudo systemctl start windscribe"
alias wsh='windscribe connect hk'
alias wsu='windscribe connect us'
alias wso='windscribe disconnect'

alias kmd='killall megasync dropbox'

mega(){
  HOME=$(pwd)
  megasync &!
  HOME=/home/ahsan
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
mpv(){ /usr/bin/mpv $@ &! }
mpvc(){ /usr/bin/mpv --loop-file=0 $@ &! }
ink(){ inkscape $@ &!  }
fig(){ inkscape --export-area-drawing --export-latex --export-filename="${1%.svg}.pdf" $1 }

ggb(){
  if [[ -f "/home/ahsan/git/atom/figs/$1.ggb" ]]
  then
  else
    cp /home/ahsan/git/atom/figs/main.ggb /home/ahsan/git/atom/figs/$1.ggb
  fi
  geogebra /home/ahsan/git/atom/figs/$1.ggb >/dev/null &!
}

splith (){
  per=$(printf %.10f\\n "$((1000000000 * 100/$1))e-9")
  if [[ -f $2 ]]
  then
    A=$@
    B=("${A[@]:1}")
    for i in $B[@]
    do
      j=$(echo $i | xargs)
      convert -crop 100%x$per% "$j" "$j"
    done
  else
    for i in *
    do
      convert -crop 100%x$per% "$i" "$i"
    done
  fi
}

splitv (){
  per=$(printf %.10f\\n "$((1000000000 * 100/$1))e-9")
  if [[ -f $2 ]]
  then
    A=$@
    B=("${A[@]:1}")
    for i in $B[@]
    do
      j=$(echo $i | xargs)
      convert -crop $per%x100% "$j" "$j"
    done
  else
    for i in *
    do
      convert -crop $per%x100% "$i" "$i"
    done
  fi
}

# rotate pictures
mr(){ mogrify -rotate $@ }
m1(){ mr 270 $@ }
m2(){ mr 180 $@ }
m3(){ mr  90 $@ }

killJava () {
  killall -9 /home/ahsan/.jenv/versions/openjdk64-17.0.3/bin/java
}

# mtype () {
#   if [[ $1 == "vid" ]] then
#     # for i in * do 
#   elif [[ $1 == "pic" ]] then
#   else
#   fi
# }

notes () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" notes $@)
}

book () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" book $@)
}

paper () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" paper $@)
}

goto () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" goto $@)
}

prac () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" prac $@)
}

pset () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" pset $@)
}

dopset () {
  eval $(python "/home/ahsan/git/oxford/misc/scripts/notes.py" dopset $@)
}

com () {
  ./compile $1; echo ""; ./a.out
}


vr='*.(mp4|mov|mkv|webm|gif)'
pr='*.(jpg|jpeg|png|PNG|JPG|webp)'

alias fv="find . -regex '$vidRegex' -type f -exec echo \"{}\" \;"
alias fp="find . -regex '$picRegex' -type f -exec echo \"{}\" \;"

alias gpssh='gcloud compute ssh --zone "us-central1-c" "main" --project "group-design-practical"'
