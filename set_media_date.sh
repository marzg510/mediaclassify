#!/bin/bash

files=${*:-*.mp4}
errcd=0
for f in $files; do
  ext="${f##*.}"
  # MediaCreateDateを持っていたらスキップ
  mcdt=$(exiftool -MediaCreateDate "$f")
  if [ "$mcdt" != "" ]; then
    mcdt_part=$(echo $mcdt | awk '{gsub(":","-",$5);print $5,$6}')
    [ "$mcdt_part" == "$(date "+%Y-%m-%d %H:%M:%S" -d "$mcdt_part" 2>/dev/null)" ] && continue
  fi
  # originalファイルはスキップ
  [[ $ext =~ original$ ]] && continue
  echo -n $f

  # 日付生成
  # ContentCreateDateを持っているか
  orgdt=$(exiftool -ContentCreateDate "$f" | sed -r 's/[^:]*: //' | awk '{gsub(":","-",$1);print $1,$2}')
  echo -n : set to $orgdt ..
  if [ "$orgdt" == "" ]; then
    # もってなければファイル名から日付を生成
    opt_nm=$(basename "$f" $ext | sed -r 's/ /_/g' | sed -r 's/\.//g').$ext
    date_part=$(basename $opt_nm .$ext)
    dt=$(echo ${date_part:0:17} | sed -r 's/-/:/g' | sed -r 's/_/ /g' | sed -r 's/ ([0-9]{2})([0-9]{2})([0-9]{2})/ \1:\2:\3+09:00/g')
  else
    dt=$orgdt
  fi
  # MediaCreateDateを設定する
  exiftool -overwrite_original -MediaCreateDate="$dt" "$f"
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd
