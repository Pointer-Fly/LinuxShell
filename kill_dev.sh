#!/bin/bash

# 检查是否提供了设备参数
if [ -z "$1" ]; then
    echo "用法: $0 /dev/设备名"
    echo "示例: $0 /dev/ttyACM0"
    exit 1
fi

DEVICE="$1"

# 检查设备是否存在
if [ ! -e "$DEVICE" ]; then
    echo "错误: 设备 $DEVICE 不存在"
    exit 1
fi

# 查找占用设备的进程
PID=$(sudo fuser "$DEVICE" 2>/dev/null | awk '{print $NF}')

if [ -z "$PID" ]; then
    echo "没有进程占用 $DEVICE"
    exit 0
fi

echo "正在终止占用 $DEVICE 的进程: $PID"
sudo kill -9 "$PID"

if [ $? -eq 0 ]; then
    echo "成功终止进程 $PID"
else
    echo "终止进程失败"
    exit 1
fi
