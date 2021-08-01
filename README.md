# Linux 程序启动脚本

## go-boot.sh 是执行 golang 程序

```
#用法: ./脚本名.sh {start|stop|restart|status}

启动:  ./go-boot.sh start

停止:  ./go-boot.sh stop 

重启：  ./go-boot.sh restart

状态   ./go-boot.sh status
```

 



## java-boot.sh 是执行 java 程序

```
#用法: ./脚本名.sh {start|stop|restart|status} {APP_NAME}

启动:  ./java-boot.sh start hello.jar

停止:  ./java-boot.sh stop hello.jar

重启：  ./java-boot.sh restart hello.jar

状态    ./java-boot.sh status hello.jar
```





## spring-boot.sh 是执行 spring boot 程序

```
#用法: ./脚本名.sh {start|stop|restart|status} {APP_NAME} {prod}

启动:  ./spring-boot.sh start hello.jar 			# 默认启动 prod

启动:  ./spring-boot.sh start hello.jar test      # 指定 spring.profiles.active 环境

停止:  ./spring-boot.sh stop hello.jar

重启：  ./spring-boot.sh restart hello.jar

状态    ./spring-boot.sh status hello.jar
```

