#!/bin/bash

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

CURR_PATH=`dirname $0`
cd $CURR_PATH

APP_ID=5
RANK_LOGS_DIR="/data/logs/${APP_ID}/rank"
LOG_FILE=./draco_rank_clean.log
SERVER_ID=`cat /data/draco/deploy/draco/env.properties |grep SERVERID|grep -E -o "[0-9]+"`
GM_HOST='127.0.0.1'
RANK_HOST='192.168.1.238'
RANK_LOG_PUSH_FILE="/data/script/rank_log_push.sh"

#the init sucess flag
sucess_substr='"failureRankIds":[],"'



echo_err()
{
    echo -e "\E[1;31m""$@ \033[0m"
    echo $@>> ${LOG_FILE}
} 
echo_ok(){
    echo -e "\E[1;32m""$@ \033[0m"
    echo $@>> ${LOG_FILE}
}

echo_ok `date` start..  
pre_hour=`date +%Y-%m-%d-%H -d "1 hour ago now"`
echo_ok rename satrt .... $pre_hour

file_list_delete=`ls $RANK_LOGS_DIR | grep .log.`

for file_delete in $file_list_delete
do
	echo_ok delete .....$file_delete
        rm   $RANK_LOGS_DIR/$file_delete
done


file_list=`ls $RANK_LOGS_DIR| grep .log | grep -v log.`
for file in $file_list
do
     echo_ok clear $file
     >$RANK_LOGS_DIR/$file
done
    


echo_ok `date` start init rank_logs from DB 

http_result=`curl -s --header "__cmdid__:10057" -d"{'commandId':10057}" "http://${GM_HOST}:10510"`
#judge if rank initialization sucess

if [[ "$http_result" =~ "$sucess_substr" ]];then
        echo_ok `date` "init sucess!"  $http_result 
else    echo_err `date` "init failed the request result is"  $http_result
        exit 1
fi
echo_ok `date`  init rank_logs from DB  end

echo_ok `date` start rename
for file in $file_list
do
    echo_ok rename $file
    #rename the new logs in an 'append' way rather than 'cover'
    cat $RANK_LOGS_DIR/$file >>$RANK_LOGS_DIR/$file.$pre_hour
done

echo_ok `date` start push

# invoke delete
#clear the rank cache
curl -s -o /dev/null  http://${RANK_HOST}:18811/del/${APP_ID}/${SERVER_ID}

echo_ok `date` clear the rank cache sucess
echo_ok APP_ID = $APP_ID
echo_ok SERVER_ID = $SERVER_ID
#push new initialized rank logs to python app
sh ${RANK_LOG_PUSH_FILE}
echo_ok `date` generate new rank end


