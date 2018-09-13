#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
. ${THIS_DIR}/commons.sh

# rename jpg
indir=${1:-./tmp}
errcd=0
find $indir -type f -iname "*.jpg" | while read f; do
  ext="${f##*.}"
  base=$(basename $f .$ext)
  # ファイル名が日付で始まるものは、何もしない
  fdt=${base:0:17}
  dt="${fdt:0:10} ${fdt:11:2}:${fdt:13:2}:${fdt:15:2}"
  [ "$dt" == "$(date "+%Y-%m-%d %H:%M:%S" -d "$dt" 2>/dev/null)" ] && continue
  # 日付取得項目の決定
  dt_item=$(get_valid_date_item $f)
  # ファイル名変更
  echo -n renaming $f by $dt_item ..
  exiftool "-FileName < $dt_item" -d %Y-%m-%d_%H%M%S%%-c.%%e $f
#  echo exiftool '-FileName < CreateDate' -d %Y-%m-%d_%H%M%S.$ext $f
#  exiftool -$dt_item $f
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd
