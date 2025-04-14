#!/bin/bash

# Check if directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

dir="$1"

# Use find to get all video files, shuffle them, and pass them to mpv in one go
find ./ -type f -iregex ".*\.\(mp4\|mkv\|webm\|gif\|mov\|avi\|wmv\|flv\)" | shuf | xargs -d '\n' mpv
