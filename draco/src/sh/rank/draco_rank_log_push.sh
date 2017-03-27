#!/bin/bash

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

CURR_PATH=`dirname $0`
cd $CURR_PATH

LOG_FILE=/data/script/draco_rank_push.log

# rsync   the repeat times
retry=3


#now_min=`date +%M`
#now_hour=`date +%H`
#now_day=`date +%Y-%m-%d`
appId='5'

rankDir='/data/logs/draco/rank'
RANK_HOST='192.168.1.238'
SERVER_ID=`cat /data/draco/deploy/draco/env.properties |grep SERVERID|grep -E -o "[0-9]+"`


echo_err()
{
    echo -e "\E[1;31m""$@ \033[0m"
} 
echo_ok(){
    echo -e "\E[1;32m""$@ \033[0m"
}
echo_ok `date` start  $SERVER_ID  >> ${LOG_FILE}
if [[ -d "$rankDir" ]]; then 
    echo_ok `date` ing >> ${LOG_FILE}
    find $rankDir -name "*.log*" -type f -ctime +14 -exec rm {} -f \;
    for ((n=0; n<$retry; n++))
    do
    	rsync -avuz --delete $rankDir/${appId}_${SERVER_ID}* ${RANK_HOST}::rank/${appId}_${SERVER_ID} && break
        sleep 3
    done
    curl -s -o /dev/null  http://${RANK_HOST}:18811/m/${appId}/${SERVER_ID}
else 
    echo_ok "$rankDir not exist"
    exit
fi

echo_ok `date` rank_log_push.sh excute end >> ${LOG_FILE}

#rsync -avuz /data/logs/rank/  ${IP}::rank/${appId}_${serverId}/
