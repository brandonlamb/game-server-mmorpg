#!bin/bash
cd `dirname $0`
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
HOST='127.0.0.1'
SHUT_DOWN_OFFLINE_OK='"type":1'
SECONDS=60
PORT=10510
LOG_FILE=./shut_down_server.log
echo_err()
{
    echo -e "\E[1;31m""$@ \033[0m"
    echo $@>> ${LOG_FILE}
}
echo_ok(){
    echo -e "\E[1;32m""$@ \033[0m"
    echo $@>> ${LOG_FILE}
}


echo_ok ${HOST}

# 
function callOffLineNoticeAction(){
    
        http_result=`curl -s -d"{'commandId':10070,'minutes':$1}" "http://${HOST}:${PORT}"`
	if [[ "$http_result" =~ "$SHUT_DOWN_OFFLINE_OK" ]];then
          	echo_ok `date` callOffLineNoticeAction "($1)"  ok the response result is:$http_result
	  	return 0
        else
		echo_err `date` callOffLineNoticeAction "($1)"  err the response result is:$http_result
		return 1
	fi
	
}

function callRejectAction(){
	
	http_result=`curl -s -d"{'commandId':10072,'type':$1}" "http://${HOST}:${PORT}"`
        if [[ "$http_result" =~ "$SHUT_DOWN_OFFLINE_OK" ]];then
                echo_ok `date` callRejectAction "($1)"  ok the response result is:$http_result
                return 0
        else
                echo_err `date` callRejectAction "($1)" err the response result is:$http_result
                return 1
        fi	
	return 0
}

callOffLineNoticeAction 3

if [[ $? = 0 ]];then
	sleep $SECONDS
	callOffLineNoticeAction 2
		if [[ $? = 0 ]];then
		sleep $SECONDS
		callOffLineNoticeAction 1
		if [[ $? = 0 ]];then
			callRejectAction 1
			if [[ $? = 0 ]];then
				echo_ok shutdown server finished
				#./easterrun.sh stop
			fi
		fi
	fi
fi
