#!/bin/sh

# ps -ef | grep Pentablet_Drive | grep -v grep | awk '{print $2}' | xargs kill

appname=`basename $0 | sed s,\.sh$,,`
dirname=`dirname $0`
tmp="${dirname#?}"

if [ "${dirname%$tmp}" != "/" ]
then
  dirname=$PWD/$dirname
fi

LD_LIBRARY_PATH=$dirname/lib
export LD_LIBRARY_PATH

$dirname/$appname "$@" 2> /dev/null &
