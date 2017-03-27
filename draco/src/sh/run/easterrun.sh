#!/bin/sh
#
CURR_PATH=`dirname $0`
cd $CURR_PATH

AREA_URL=http://192.168.1.180:19310/env


#JAVA_HOME=/usr/local/java
SERVER_NAME=`pwd`/easterrun.sh

STDOUT=`pwd`/stdout.log
STDERR=`pwd`/stderr.log
#STDOUT=/dev/null
#STDERR=/dev/null

ARGS=
APPID=app_game_draco
GAME_APPID=5
GAME_PORT=10500
GAME_JMX_PORT=10000
PROPERTY=java.nio.channels.spi.SelectorProvider=sun.nio.ch.EPollSelectorProvider


CLASS_NAME=sacred.alliance.magic.core.server.Server

LIB=`pwd`/lib

JARS=(`ls lib`)
DIRNUM=${#JARS[@]}

CLASS_PATH=./

index=0
while [ $index -lt $DIRNUM ]
do
  CLASS_PATH=$CLASS_PATH:$LIB/${JARS[$index]}
  let "index= $index + 1"
done

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

counter=`ps -ef|grep $APPID |grep java|grep -v grep|wc -l`
procid=`ps -ef|grep $APPID |grep java|grep -v grep |awk '{print $2}'`

#=============================================================================
start()
{
if [ $counter -ge 1 ]
        then
                echo
                echo The $SERVER_NAME Server already Started!
                echo
        else
		echo "start to get the serverId"
		user=`whoami`
		echo "user is $user"
		if [[ "$user" != "moogame" && "$user" != "game" ]] ; then
			echo "user is $user ,plase change user [moogame]"
			exit
		fi
		
		macs=`/sbin/ifconfig | awk '/HWaddr /{printf "%s;",$5}'`		

		local_start_date=`cat env.properties|grep "SHENZHOU_STARTDATE"|awk -F"=" '{print $2}'`
		area_start_date=`curl -s "$AREA_URL?macs=$macs&port=$GAME_PORT"|grep "SHENZHOU_STARTDATE"|awk -F"=" '{print $2}'`
		if [[ "$local_start_date" != "$area_start_date" ]] ; then
			echo "start date error,please check start date"
			exit
		fi


		server_id=`curl -s "$AREA_URL?macs=$macs&port=$GAME_PORT"|grep "SERVERID"|awk -F"=" '{print $2}'`
                echo "the serverId= $server_id"
		
		len_serverid=`echo $server_id|wc -L`
                if [ $len_serverid -lt 1 ] ; then
                        echo "get the server id error "
			exit;
                fi

		server_id_str="SERVERID=$server_id"
                server_id_env_str=`cat env.properties|grep "SERVERID"`
                if [[ "$server_id_str" != "$server_id_env_str" ]] ; then
                        echo "server id error please check deploy"
                        exit
                fi	
	
		JMX_IP=`curl "$AREA_URL?macs=$macs&port=$GAME_PORT"|grep "HOST_IP"|awk -F"=" '{print $2}'`
		len_JMX_IP=`echo $JMX_IP|wc -L`
		if [ $len_JMX_IP -lt 1 ] ; then
                        echo "get the JMX_IP error "
			exit;
                fi
                 
                echo "the serverId= $server_id"
                echo "the jmx ip= $JMX_IP"

                cd $CURR_PATH
                echo "start to gen the logback.xml"
                rm -rf logback.xml logback-stat.xml
                cp ./log_conf/logback-stat.xml ./logback-stat.xml


                serverid_replace='<!--serverId-->'
		appid_replace='<!--appId-->'
 		statlog_replace='<!--statlogconfig-->'

                sed -i "s/${serverid_replace}/$server_id/g" ./logback-stat.xml
                sed -i "s/${appid_replace}/$GAME_APPID/g" ./logback-stat.xml

                cp ./log_conf/logback.xml ./logback.xml
	        
		sed -i '/'"${statlog_replace}"'/r ./logback-stat.xml' ./logback.xml
                sed -i '/'"${statlog_replace}"'/d' ./logback.xml	

                rm -rf logback-stat.xml

                echo "gen the logback.xml success "

                echo Start The $SERVER_NAME Server....
               
               java -D$APPID -verbosegc -Dcom.sun.management.jmxremote.port=$GAME_JMX_PORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=$JMX_IP -d64 -server -Xmx512m -Xms128m -Xss256k -classpath $CLASS_PATH -D$PROPERTY $CLASS_NAME $ARGS>>$STDOUT 2>>$STDERR & 
               #java -D$APPID $JP -classpath $CLASS_PATH -D$PROPERTY $CLASS_NAME $ARGS>>$STDOUT 2>>$STDERR & 

                sleep 2
                counter=`ps -ef|grep $APPID |grep java|grep -v grep|wc -l`
                if [ $counter -eq 1 ]
                        then
                                echo The $SERVER_NAME Server Started!
                                echo
                        else
                               
				echo The $SERVER_NAME Server Start Failed
                                echo please Check the system
                                echo
                fi
fi
}

stop()
{
if  [ $counter -eq 1 ]
        then    
                echo
                echo Stop The $SERVER_NAME Server....
                echo
         
                kill $procid
                sleep 5
                counter=`ps -ef|grep $APPID |grep java|grep -v grep|wc -l`
                if [ $counter -eq 1 ]
                        then
                                echo The $SERVER_NAME Server NOT Stoped!
                                echo please Check the system
                                echo
                        else
                                echo The $SERVER_NAME Server Stoped
                                echo
                fi
        else
                echo
                echo The $SERVER_NAME Server already Stoped!
                echo
fi
}



status()
{
echo
if [ $counter -ge 1 ]
        then
                                echo "The $SERVER_NAME Server Running($procid)!"
                                echo
        else
                echo
                echo The $SERVER_NAME Server NOT Running!
                echo
fi
}

case "$1" in
'start')
                start
        ;;
'stop')
                stop
        ;;
'restart')
		stop
		start
	;;
'status')
                status
        ;;
*)
        echo
        echo
        echo "Usage: $0 {status | start | stop }"
        echo
        echo Status of $SERVER_NAME Servers ......
                status
        ;;
esac
exit 0


