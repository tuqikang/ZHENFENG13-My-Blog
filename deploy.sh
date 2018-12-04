#!/usr/bin/env bash


cd $PROJ_PATH
#mvn clean package

pid=`netstat -anp|grep 8888|awk '{printf $7}'|cut -d/ -f1`

kill -9 $pid
mvn clean install
cd target/
nohup java -jar my-blog-3.3.0-SNAPSHOT.jar &





