#!/bin/bash

export LANG=zh_CN.UTF-8

DIR_NAME=`dirname $0`
cd $DIR_NAME

LIB_PATH=`ls -l |grep lib|awk -F'->' '{print $2}'`

cd $LIB_PATH
cd ../

CURRENT_PATH=`pwd`
echo " "
echo "--------- current path: $CURRENT_PATH -------------"
echo " "
svn up
echo "================================"
echo "======svn up code success======="
echo "================================"
echo " "

ant
echo " "
echo " "
echo "=====compile code success======="
echo " "
