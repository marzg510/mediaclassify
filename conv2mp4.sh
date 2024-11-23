#!/bin/bash

files=${*:-*.*}

errcd=0

for f in $files; do
  ext="${f##*.}"
  echo $f
  opt_nm=$(basename "$f" $ext | sed -r 's/ /_/g' | sed -r 's/\.//g').$ext
  of=./$(basename "$opt_nm" .$ext).mp4
  # DateTimeOriginalから日付を設定
  dt=$(exiftool -DateTimeOriginal "$f" | awk '{gsub(":","-",$4);print $4,$5}')
  if [ "$ext" == "avi" ]; then
    codec='-vcodec h264 -acodec aac -strict -2'
  else
    codec='-c copy'
#    codec='-vcodec copy -acodec copy'
  fi
#  loglevel=info
  loglevel=warning
  echo ffmpeg -y -loglevel $loglevel -i "$f" $codec -metadata date="$dt" $of
  ffmpeg -y -loglevel $loglevel -i "$f" $codec -metadata date="$dt" $of
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd

