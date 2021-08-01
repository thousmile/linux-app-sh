#!/bin/bash
#chkconfig:345 61 61
#description: Spring Boot App Script
#auther: Wang Chen Chen

#===========================================================================================
# Document And Example
#===========================================================================================
#用法: ./脚本名.sh {start|stop|restart|status} {APP_NAME}
#例子(一)：./spring-boot.sh start example.jar 					# 默认启动
#例子(二)：./spring-boot.sh start example.jar prod 				# 指定环境

#===========================================================================================
# Spring Boot Application Start Configuration
#===========================================================================================

# Spring Boot App 名称
APP_NAME=$2

# spring.profiles.active 配置激活环境
SPRING_ENV=$3

# JVM参数
JVM_OPTS="-server -Xms256m -Xmx256m -XX:+HeapDumpOnOutOfMemoryError -Dname=$APP_NAME -Dfile.encoding=UTF-8 -Duser.timezone=Asia/Shanghai -Djava.security.egd=file:/dev/./urandom"

#JDK路径
JAVA_HOME=./jdk-11.0.11+9

# 第一个参数 start|stop|restart|status 中的一个
if [ "$1" = "" ];
then
    echo -e "\033[0;31m 未输入操作名 \033[0m  \033[0;34m {start|stop|restart|status} \033[0m"
    exit 1
fi


# 第二个参数 xxx.jar 包名称
if [ "$APP_NAME" = "" ];
then
    echo -e "\033[0;31m 未输入应用名 \033[0m"
    exit 1
fi


# 第三个参数 spring.profiles.active 配置激活环境
if [ "$SPRING_ENV" = "" ];
then
	SPRING_ENV=prod
fi


# 启动
function start()
{
    PID=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`
    if [ $PID != 0 ];then
        echo "$APP_NAME is running..."
    else
        echo "start $APP_NAME active: $SPRING_ENV success..." &
		    nohup $JAVA_HOME/bin/java -jar $APP_NAME --spring.profiles.active=$SPRING_ENV >/dev/null 2>&1 &
    fi
}


# 停止
function stop()
{
	PID=""
	query(){
		PID=`ps -ef |grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'`
	}
	query
	if [ x"$PID" != x"" ]; then
		kill -TERM $PID
		echo "$APP_NAME (pid:$PID) exiting..."
		while [ x"$PID" != x"" ]
		do
			sleep 1
			query
		done
		echo "$APP_NAME exited ..."
	else
		echo "$APP_NAME already stopped ..."
	fi
}


# 重启
function restart()
{
    stop
    sleep 2
    start
}


# 查看状态
function status()
{
    PID=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`
    if [ $PID != 0 ];then
        echo "$APP_NAME is running..."
    else
        echo "$APP_NAME is stop..."
    fi
}


case $1 in
    start)
    start;;
    stop)
    stop;;
    restart)
    restart;;
    status)
    status;;
    *)

    echo -e "\033[0;31m Usage: \033[0m  \033[0;34m sh  $0  {start|stop|restart|status}  {APP_NAME} \033[0m
\033[0;31m Example: \033[0m
      \033[0;33m sh  $0  start example.jar \033[0m"
esac
