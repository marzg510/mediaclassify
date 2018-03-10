#!/bin/bash

files=${*:-*.mp4}
errcd=0
for f in $files; do
  echo -n classifing $f .. 
  exiftool '-Directory < ContentCreateDate' -d %Y/%Y-%m $f
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd
