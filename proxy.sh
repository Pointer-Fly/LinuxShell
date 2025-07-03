#!/bin/bash

# set proxy config via profile.d - should apply for all users
IP="192.168.3.61:7897"
TEST_URL="http://www.google.com"  # 用于测试代理的URL

# 检测代理是否可用的函数
check_proxy() {
    local proxy_url="http://${IP}/"
    local timeout=3  # 设置超时时间(秒)
    
    # 使用curl测试代理
    if curl --silent --connect-timeout $timeout --max-time $timeout --proxy $proxy_url $TEST_URL >/dev/null; then
        return 0  # 代理可用
    else
        return 1  # 代理不可用
    fi
}

# 主逻辑
if check_proxy; then
    # 设置代理环境变量
    export http_proxy="http://${IP}/"
    export https_proxy="http://${IP}/"
    export ftp_proxy="http://${IP}/"
    export no_proxy="127.0.0.1,localhost"
    # For curl
    export HTTP_PROXY="http://${IP}/"
    export HTTPS_PROXY="http://${IP}/"
    export FTP_PROXY="http://${IP}/"
    export NO_PROXY="127.0.0.1,localhost"
    echo "成功设置代理：${IP}"
else
    # 取消所有代理设置
    unset http_proxy https_proxy ftp_proxy no_proxy
    unset HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY
    echo "代理 ${IP} 不可用，未设置代理"
fi
