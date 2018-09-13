#!/bin/bash

function test() {
  echo 0
  return 0
}

function is_valid_exif_date() {
  dt_item=$1
  in_f=$2
  exif_dt=$(exiftool -$dt_item "$in_f")
#  echo exif_dt=$exif_dt >&2
  dt=$(echo $exif_dt | sed -r 's/[^:]*: //' | awk '{gsub(":","-",$1);print $1,$2}')
  validation_dt=$(date "+%Y-%m-%d %H:%M:%S" -d "$dt" 2>/dev/null)
#  echo dt=$dt >&2
#  echo vdt=$validation_dt >&2
  [ "$dt" == "$validation_dt" ] && echo true || echo false
}

function get_valid_date_item() {
  in_f=$1
  dt_item="ContentCreateDate"
  if $(is_valid_exif_date $dt_item "$in_f"); then
    echo $dt_item
    return 0
  fi
  
  dt_item="CreateDate"
  if $(is_valid_exif_date $dt_item "$in_f"); then
    echo $dt_item
    return 0
  fi
  echo "FileModifyDate"
}

# ファイル名が日付で始まるかチェック
function is_filename_date() {
  f=$1
  ext="${f##*.}"
  base=$(basename $f .$ext)
  fdt=${base:0:17}
  dt="${fdt:0:10} ${fdt:11:2}:${fdt:13:2}:${fdt:15:2}"
  [ "$dt" == "$(date "+%Y-%m-%d %H:%M:%S" -d "$dt" 2>/dev/null)" ] && echo true || echo false
}

if [ "$(basename $0)" == "commons.sh" ]; then
  $*
fi
