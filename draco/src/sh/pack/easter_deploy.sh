#!/bin/bash

export LANG=zh_CN.UTF-8

DEPLOY_ROOT=/data/deploy
RES_ROOT=/data/project/easter_res
PROJECT_ROOT=/data/project
PROJECT_NAME=easter
ON_DEPLOY_CONF_PATH=/data/deploy/deployProject/easter/on_deploy
ENV_LIST_PATH=/data/deploy/deployProject/easter/env_list


if [ $# -ne 2 ] ; then
  echo '-------------------------'
  echo "USAGE: $0 code_ver_pre res_ver_pre"
  echo " e.g.: $0 0.0.6 0.0.6"
  echo '-------------------------'
  exit ;
fi

CODE_VERSION=$1
RES_VERSION=$2

RES_PATH=$RES_ROOT/gameData_$RES_VERSION
PROJECT_PATH=$PROJECT_ROOT/easter_$CODE_VERSION
DEPLOY_PATH=${DEPLOY_ROOT}/${PROJECT_NAME}_${CODE_VERSION}

if [ ! -d "$RES_PATH" ]; then
    echo "the res not exist,path=$RES_PATH"
    exit
fi


if [ ! -d "$PROJECT_PATH" ]; then
    echo "the code not exist,path=$PROJECT_PATH"
    exit
fi


if [ -d "$DEPLOY_PATH" ]; then
    echo "the deploy had exist,path=$DEPLOY_PATH"
    exit
fi

mkdir -p $DEPLOY_PATH

cd $DEPLOY_PATH

mkdir logs resources

ln -s env/area-ice.client area-ice.client
ln -s $PROJECT_PATH/conf/config.properties config.properties
ln -s $PROJECT_PATH/conf/db-pool.properties db-pool.properties
ln -s ./env/easterrun.sh easterrun.sh
ln -s ./env_list/env_test env
ln -s $ENV_LIST_PATH env_list
ln -s $PROJECT_PATH/external-conf/ex-spring ex-spring
ln -s $PROJECT_PATH/conf/ibatis ibatis
ln -s $PROJECT_PATH/lib lib
ln -s $PROJECT_PATH/conf/log log_conf
ln -s $PROJECT_PATH/conf/quartz.properties quartz.properties
ln -s $PROJECT_PATH/release_notes.txt release_notes.txt
ln -s $PROJECT_PATH/conf/spring spring
ln -s $PROJECT_PATH/sql sql
ln -s ./env/stopserver.sh stopserver.sh
ln -s $PROJECT_PATH/update_list.txt update_list.txt

cp $ON_DEPLOY_CONF_PATH/*.* ./

chmod +x *.sh

cd $DEPLOY_PATH/resources

ln -s $RES_PATH/map_data map_data
ln -s $RES_PATH/resource resource
ln -s $RES_PATH/script script
ln -s $RES_PATH/txt txt
ln -s $RES_PATH/xls xls


echo ""
echo "============== success ================"
