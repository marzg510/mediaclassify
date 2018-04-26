#!/bin/bash

function test() {
  echo 0
  return 0
}

function get_valid_date_item() {
  in_f=$1
  dt_item="CreateDate"
  tmpdt=$(exiftool -$dt_item "$in_f" | sed -r 's/[^:]*: //' | awk '{gsub(":","-",$1);print $1,$2}')
  if [ "$tmpdt" == "" ]; then
    dt_item="FileModifyDate"
  fi
  echo $dt_item
}


if [ "$(basename $0)" == "commons.sh" ]; then
  $*
fi
