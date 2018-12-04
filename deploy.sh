#!/usr/bin/env bash
#编译+部署order站点

#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export PROJ_PATH=这个jenkins任务在部署机器上的路径

# 输入你的环境上tomcat的全路径
# export TOMCAT_APP_PATH=tomcat在部署机器上的路径

cd $PROJ_PATH
#mvn clean package

get_pid(){
    pname="`find .. -name 'my-blog*.jar'`"
    pname=${pname:3}
    pid=`ps -ef | grep $pname | grep -v grep | awk '{print $2}'`
    echo "$pid"
}

shut_down(){
    pid=$(get_pid)
    if [ "$pid" != "" ]
    then
        kill -9 $pid
        echo "Blog is stop!"
    else
        echo "Blog already stop!"
    fi
}

startup(){

    #构建并启动
    mvn clean install -Dmaven.test.skip=true
    pid=$(get_pid)
    if [ "$pid" != "" ]
    then
        echo "Blog already startup!"
    else
        jar_path=`find .. -name 'my-blog*.jar'`
        echo "jarfile=$jar_path"
        cmd="java $1 -jar $jar_path > ./my-blog.out < /dev/null &"
        echo "cmd: $cmd"
        java $1 -jar $jar_path > ./my-blog.out < /dev/null &
        show_log
    fi
}


shut_down
startup



