#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
. ${THIS_DIR}/commons.sh

# classify jpg
indir=${1:-./tmp}
outdir=${2:-./tmp}
errcd=0
find $indir -type f -iname "*.jpg" | while read f; do
  echo -n classifing $f .. 
  dt_item=$(get_valid_date_item $f)
  exiftool "-Directory < $dt_item" -d $outdir/%Y/%Y-%m $f
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd
