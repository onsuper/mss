#!/bin/sh
cfgfile="/etc/ss-srv.json"

# 检查必需的环境变量
if [ -z "$PASSWORD" ]; then
    echo "ERROR: PASSWORD is not set."
    exit 1
fi
 
if [ -z "$METHOD" ]; then
    echo "ERROR: METHOD is not set."
    exit 1
fi

if [ -z "$PORT" ]; then
    echo "ERROR: PORT is not set."
    exit 1
fi

# 生成配置文件
cat <<EOL > $cfgfile
{
	"server_port": $PORT,
	"method": "$METHOD",
	"password": "$PASSWORD",
	"ipv6_first": false,
	"fast_open": true,
	"reuse_port": false,
	"no_delay": true,
	"mode": "tcp_and_udp",
	"timeout": 600
}

EOL

echo $cfgfile

cat $cfgfile

# 启动 Shadowsocks
mkdir -p /run/ss-server /var/log/ss-server
exec ./usr/bin/ss-server -c $cfgfile

#./usr/bin/ss-server -c /etc/ss-srv.json