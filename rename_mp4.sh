#!/bin/bash

# rename
files=${*:-*.mp4}
for f in $files; do
  ext="${f##*.}"
  base=$(basename $f .$ext)
  # ファイル名が日付で始まるものは、何もしない
  fdt=${base:0:17}
  dt="${fdt:0:10} ${fdt:11:2}:${fdt:13:2}:${fdt:15:2}"
  [ "$dt" == "$(date "+%Y-%m-%d %H:%M:%S" -d "$dt" 2>/dev/null)" ] && continue
  echo -n renaming $f ..
  exiftool '-FileName<ContentCreateDate' -d %Y-%m-%d_%H%M%S_%%f.$ext $f
done

