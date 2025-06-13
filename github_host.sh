#!/bin/bash

hosts_path=/etc/hosts         # 系统 hosts 保存路径
hosts_path_bak=/etc/hosts.bak # 系统 hosts 备份路径

# 备份 hosts
echo "########## 备份 $hosts_path 到 $hosts_path_bak ##########"
sudo cp $hosts_path $hosts_path_bak

# 删除 hosts 中原有 github 相关配置
echo "########## 删除 $hosts_path 中 GitHub 相关配置 ##########"
sudo sed -i ":begin; /# GitHub Host Start/,/# GitHub Host End/ { /# GitHub Host End/! { $! { N; b begin }; }; s/# GitHub Host Start.*# GitHub Host End//; };" $hosts_path
sudo sh -c "sed -i '/^$/d' $hosts_path" # 删除系统 hosts 文件中的空行

# 使用 nslookup 获取域名 IP 地址
echo "########## 获取 GitHub 域名 IP 地址 ##########"
github_ip=$(nslookup github.com | awk '/^Address: / { print $2; exit }')
fastly_ip=$(nslookup github.global.ssl.fastly.net | awk '/^Address: / { print $2; exit }')

# 检查是否成功获取 IP
if [ -z "$github_ip" ] || [ -z "$fastly_ip" ]; then
    echo "错误：无法获取 GitHub 或 Fastly 的 IP 地址"
    exit 1
fi

# 创建新的 hosts 内容
host_value="# GitHub Host Start
$github_ip    github.com
$fastly_ip    github.global.ssl.fastly.net
# GitHub Host End"

# 更新 hosts
echo "########## 更新 $hosts_path 中的 GitHub 相关配置 ##########"
echo "$host_value" | sudo tee -a $hosts_path > /dev/null

echo "########## GitHub hosts 更新完成 ##########"
