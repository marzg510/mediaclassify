#!/bin/bash

files=${*:-*.mp4}
for f in $files; do
  echo -n classifing $f .. 
  exiftool '-Directory < ContentCreateDate' -d %Y/%Y-%m $f
done

