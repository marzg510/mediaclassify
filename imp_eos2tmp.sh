#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
. ${THIS_DIR}/commons.sh

FROM_DIR=/media/masaru/EOS_DIGITAL/DCIM/
TO_DIR=/tmp/eos`date +%Y%m%d_%H%M%S`


# copy to tmp
echo "mkdir $TO_DIR"
mkdir -p $TO_DIR
echo "copying $FROM_DIR to $TO_DIR"
cp -pr $FROM_DIR $TO_DIR

