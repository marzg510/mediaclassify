#!/bin/bash

THIS_DIR=$(cd $(dirname $0);pwd)
. ${THIS_DIR}/commons.sh

TMP_DIR=/tmp/eos`date +%Y%m%d_%H%M%S`

echo "start automatic imp eos pictrures"
echo "tmp dir=${TMP_DIR}"

# copy eos to tmp
echo "imp eos to tmp"
${THIS_DIR}/imp_eos2tmp.sh ${TMP_DIR}

# rename jpg
echo "rename jpg"
${THIS_DIR}/rename_jpg.sh ${TMP_DIR}

# classify jpg
echo "classify jpg"
OUT_DIR=~/Pictures/tmp_`date +%Y%m%d_%H%M%S`
echo "OUT_DIR=${OUT_DIR}"
mkdir -p ${OUT_DIR}
${THIS_DIR}/classify_jpg.sh ${TMP_DIR} ${OUT_DIR}

# delete tmp
echo "delete tmp dir"
rm -r ${TMP_DIR}

echo "end automatic imp eos pictrures"

