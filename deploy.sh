#!/usr/bin/env bash
#编译+部署order站点

#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export PROJ_PATH=这个jenkins任务在部署机器上的路径

# 输入你的环境上tomcat的全路径
# export TOMCAT_APP_PATH=tomcat在部署机器上的路径

cd $PROJ_PATH
#mvn clean package
pname="`find .. -name 'my-blog*.jar'`"
pname=${pname:3}
pid=`ps -ef | grep $pname | grep -v grep | awk '{print $2}'`
kill -9 $pid
mvn clean install
cd target/
nohup java -jar my-blog-3.3.0-SNAPSHOT.jar &





