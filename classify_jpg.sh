#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
. ${THIS_DIR}/commons.sh

DEFAULT_DIR=./tmp
# classify jpg
indir=${1:-$DEFAULT_DIR}
outdir=${2:-$DEFAULT_DIR}
echo "indir=$indir, outdir=$outdir"
[[ ! -d $indir ]] && echo "indir=$indir is not a directory" && exit 1
[[ ! -d $outdir ]] && echo "outdir=$outdir is not a directory" && exit 1
[[ ! -d $outdir ]] && mkdir -p $outdir
errcd=0
find $indir -type f -iname "*.jpg" | while read f; do
  echo -n classifing $f .. 
  dt_item=$(get_valid_date_item $f)
  exiftool "-Directory < $dt_item" -d $outdir/%Y/%Y-%m $f
  ret=$?
  [[ $ret -gt $errcd ]] && errcd=$ret
done

exit $errcd
