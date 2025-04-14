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
alias rotate="mogrify -rotate"
# rotate(){ 
#   mogrify -rotate $@ 
# }
# m1(){ mr 270 $@ }
# m2(){ mr 180 $@ }
# m3(){ mr  90 $@ }

tren_s () {
  perl-rename 's/(.*)-(\d{4})(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2})-(.........).*\.(.*)$/\/home\/ahsan\/\.done\/$1\/$2-$3-$4_$5-$6-$7_$8\.$9/' *
}
