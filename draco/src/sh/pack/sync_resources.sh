#!/bin/bash
export LANG=zh_CN.UTF-8

DIR_NAME=`dirname $0`
cd $DIR_NAME

cd resources

XLS_PATH=`ls -l |grep xls|awk -F'->' '{print $2}'`

cd $XLS_PATH
cd ../

CURRENT_PATH=`pwd`
echo " "
echo "------- current path: $CURRENT_PATH  -------"
echo " "
svn up
echo '---------- sync resources success ---------'
