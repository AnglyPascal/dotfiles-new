#!/bin/sh

# for d in */ ; do

#   if [ $d != "Manga_1/" ] && [ $d != "Manga_2/" ] && [ $d != "Manga_3/" ] && [ $d != "Pictures/" ]  && [ $d != "Pictures_2/" ] && [ $d != "GARNiDELiA_Others_Interviews/" ]
#   then
#     HOME=$(pwd)/$d;
#     echo $d;
#     # Remove the comment by your need 
#     # megasync                    # first run (configure client by client at once)
#     megasync 2> /dev/null &     # load all clients at non blocking way
#   fi
# done

cd /run/media/ahsan/d81319e4-5b9a-4883-800e-3b0c42b732d7/Templates/.done;

for d in */ ; do

  HOME=$(pwd)/$d
  echo $d;
  megasync 2> /dev/null &

done
