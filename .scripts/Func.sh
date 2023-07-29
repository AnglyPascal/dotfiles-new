Convertion: 

ffmpeg -i error.mkv -vn -c:a libmp3lame -y error.mp3


Batch convertion: 

for i in *.blv; do ffmpeg -i "$i" -codec copy "${i%.blv}.mkv"; done
for i in *.epub; do ebook-convert "$i" "${i%.epub}.pdf"; done
for i in *.png; do convert "$i" "${i%.png}.jpg"; done
for i in *.jpg; do convert "$i" "${i%.jpg}.png"; done


Lame+ffmpeg: 	

ffmpeg -i input -f wav - | lame -V4 - output.mp3


Takeing SS and copy to clipboard and save:

spectacle -b -r -n -o "/home/ahsan/Pictures/Screenshots/temp.jpg"; xclip -sel clip -t image/jpg "/home/ahsan/Pictures/Screenshots/temp.jpg"; mv -i "/home/ahsan/Pictures/Screenshots/temp.jpg" "/home/ahsan/Pictures/Screenshots/ScreenShot-$(date +%Y%m%d%H%M%S).jpg"

spectacle -f -b -n -o for full monitor
spectacle -a -b -n -o for window


Concatenation of MP4, FLV, MKV:

for i in *.mp4; do ffmpeg -i "$i" -c copy -bsf:v h264_mp4toannexb -f mpegts "${i%.mp4}.ts"; done
ffmpeg -i "concat:64.ts|65.ts" -c copy aac_adtstoasc output.mp4

for f in ./*.mp4; do echo "file '$f'" >> mylist.txt; done; ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.mp4


  Trim: 

  ffmpeg -i 0.mkv -ss 00:13:17 -to 00:15:02 -c copy output.mkv


  MP3 Covertion: 	

  for i in *.mp4; do ffmpeg -i "$i" -vn -acodec libmp3lame -ac 2 -ab 188k -ar 48000 "${i%.mp4}.mp3"; done
  ffmpeg -i "x.mp4" -vn -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 "x.mp3"

  for f in *.m4a; do ffmpeg -i "$f" -acodec libmp3lame -ab 256k "${f%.m4a}.mp3"; done


  Bulk Rename:

  a=1
  for i in *.mp4; do new=$(printf "%02d" "$a"); 	mv -i -- "$i" "Episode - $new.mp4";	let a=a+1; done
  for i in *.pdf; do new=$(printf "%04d" "$a"); rename "s/^..../$new/" "$i"; let a--; done
  for i in *.jpg; do new=$(printf "%02d" "$a");   mv -i -- "$i" "1002410827532517376-20180601_104539$new.jpg"; let a=a+1; done

  for i in *.jpg; do new=$(printf "000" "$i");   mv -i -- "$i" ""; done


  Dividing a Folder:

  i=0; 
  for f in *;  do d=dir_$(printf %03d $((i/300+1))); mkdir -p $d; mv "$f" $d; let i++; done


  Move files to the parent directory:

  find . -mindepth 2 -type f -print -exec mv {} . \;


  Twitter Renaming:		

  ubuntu: for file in *.jpg *.png; do n=${file%_*}; n=${n%-*}; n=${n%-*}; n+="-"; rename "s/$n//" *; done;  rename "s/-img//" *
  arch:		


  zip subfolders individually:

  for i in */; do zip -r "${i%/}.zip" "$i"; done


  gif videos:

  for k in *.mp4; do ffmpeg -i $k -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - "${k%.mp4}.gif"; done
