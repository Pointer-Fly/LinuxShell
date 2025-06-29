#!/bin/bash

if [ -z "$1" ]; then
    echo "用法: $0 <端口号>"
    exit 1
fi

PORT=$1

# 查找占用指定端口的进程PID
pid=$(netstat -tunlp 2>/dev/null | awk -v port=":$PORT" '$4 ~ port {split($7,a,"/"); print a[1]}')

if [ -z "$pid" ]; then
    echo "✅ 没有发现占用 ${PORT} 端口的进程"
    exit 0
fi

# 获取进程详细信息
process_info=$(ps -p $pid -o pid,user,cmd --no-headers)

echo "发现占用 ${PORT} 端口的进程："
echo "--------------------------------"
echo "$process_info"
echo "--------------------------------"

# 确认操作
read -p "是否终止该进程? (y/n) " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "❌ 操作已取消"
    exit 0
fi

# 终止进程
kill -9 $pid 2>/dev/null

# 验证结果
if netstat -tunlp 2>/dev/null | grep -q ":$PORT"; then
    echo "❌ 未能成功终止进程 $pid"
    exit 1
else
    echo "✅ 成功终止进程 $pid"
    exit 0
fi
