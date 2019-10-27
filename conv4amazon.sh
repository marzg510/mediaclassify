#!/bin/bash

conv2mp4.sh $*
if [ $? -ne 0 ]; then
  echo conv2mp4 error
  exit 9
fi
set_media_date.sh *.mp4
if [ $? -ne 0 ]; then
  echo set_media_date.sh error
  exit 9
fi
rename_mp4.sh .
if [ $? -ne 0 ]; then
  echo rename_mp4.sh error
  exit 9
fi
mkdir -p ./tmp
classify_mp4.sh . ./tmp
exit $?

