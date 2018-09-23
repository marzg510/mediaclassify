#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
. ${THIS_DIR}/commons.sh

# rename mp4
indir=${1:-./tmp}
errcd=0
find $indir -type f -iname "*.mp4" | while read f; do
  # ファイル名が日付で始まるものは、何もしない
  $(is_filename_date $f) && continue
  # 日付取得項目の決定
  dt_item=$(get_valid_date_item $f)
  echo -n renaming $f by $dt_item ..
  exiftool "-FileName<$dt_item" -d %Y-%m-%d_%H%M%S_%%f.%%e $f
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd
