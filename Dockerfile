# 使用 Alpine 作为基础镜像
FROM alpine:latest

# 设置环境变量
ENV PORT=19806
ENV PASSWORD=bWFpbDoyODIxNTYyNjhAcXEuY29t
ENV METHOD=chacha20-ietf-poly1305

# 安装必要的依赖
RUN apk --no-cache add --repository http://mirrors.cloud.tencent.com/alpine/edge/main libsodium
RUN apk --no-cache add --repository http://mirrors.cloud.tencent.com/alpine/edge/testing shadowsocks-libev

# 复制启动脚本
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# 暴露 Shadowsocks 使用的端口
EXPOSE $PORT

# 启动脚本
CMD ["/usr/local/bin/start.sh"]
