#!/bin/bash

NOW=`date '+%Y-%m-%d %H:%M:%S'` # 定义log的时间格式
BASE_DIR="/mnt/sympad" # 程序目录
PKG_DIR="/opt/sympad/pkg" # 源程序目录
PROCESS_NAME="LDog.ex" # 你要监测的程序名
PROCESS_PATH="$BASE_DIR/$PROCESS_NAME"

SLEEP_TIME=5s # 监测间隔

env

if [ ! -f "$PROCESS_PATH" ]; then
	echo "$NOW copy package SymLink files..."
	mkdir -p $BASE_DIR
	cp -r $PKG_DIR/* $BASE_DIR
fi

echo "$NOW make $PROCESS_NAME been executable"
chmod a+x $PROCESS_NAME

# 启动程序
echo "$NOW start process $PROCESS_NAME"
$PROCESS_PATH & 

# 等待运行
sleep 3

# 无限循环（0<1）
while [ 0 -lt 1 ] 
do
    NOW=`date '+%Y-%m-%d %H:%M:%S'`
    ret=`ps aux | grep "$PROCESS_NAME" | grep -v grep | wc -l`
    if [ $ret -eq 0 ]; then # 如果ps找不到运行的目标进程就拉起
        echo "$NOW process $PROCESS_NAME not exists, start it!"
		$PROCESS_PATH & 
    else
        echo "$NOW process $PROCESS_NAME exists , sleep $SLEEP_TIME seconds "
    fi
    
    sleep $SLEEP_TIME
done

echo "START END!"
