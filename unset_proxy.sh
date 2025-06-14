 # set proxy config via profie.d - should apply for all users
export http_proxy=""
export https_proxy=""
export ftp_proxy=""
export no_proxy="127.0.0.1,localhost"
# For curl
export HTTP_PROXY=""
export HTTPS_PROXY=""
export FTP_PROXY=""
export NO_PROXY="127.0.0.1,localhost"
echo "取消代理成功"
#将要从代理中排除的其他IP添加到NO_PROXY和no_proxy环境变量中
