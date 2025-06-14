# set proxy config via profile.d - should apply for all users
IP="192.168.3.61:7897"
export http_proxy="http://${IP}/"
export https_proxy="http://${IP}/"
export ftp_proxy="http://${IP}/"
export no_proxy="127.0.0.1,localhost"
# For curl
export HTTP_PROXY="http://${IP}/"
export HTTPS_PROXY="https://${IP}/"
export FTP_PROXY="http://${IP}/"
export NO_PROXY="127.0.0.1,localhost"
echo "成功设置代理：${IP}"
#将要从代理中排除的其他IP添加到NO_PROXY和no_proxy环境变量中
