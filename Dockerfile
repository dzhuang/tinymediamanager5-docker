#
# TinyMediaManager Dockerfile
#
# 注意：使用 alpine-3.22-v4 并手动安装 glibc 以支持 TinyMediaManager 的 glibc 依赖
FROM jlesage/baseimage-gui:alpine-3.22-v4

# 定义软件版本
ARG TMM_VERSION=5.2.5

# 定义软件下载 URL
ARG TMM_URL=https://release.tinymediamanager.org/v5/dist/tinyMediaManager-${TMM_VERSION}-linux-amd64.tar.xz

# 定义工作目录
WORKDIR /tmp

# 安装 glibc 兼容层 (sgerrand)
RUN apk add --no-cache wget ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk && \
    apk add --no-cache glibc-2.35-r1.apk && \
    rm glibc-2.35-r1.apk

# 下载 TinyMediaManager
RUN \
    mkdir -p /defaults && \
    wget ${TMM_URL} -O /defaults/tmm.tar.xz

# 安装依赖项
RUN apk add --no-cache libmediainfo ttf-dejavu bash zenity tar zstd fontconfig xz zlib

# 修复 Java Segmentation Fault (由于我们使用的是 glibc 兼容层，仍可能需要此修复)
RUN mkdir -p /usr/glibc-compat/lib && \
    cp /usr/lib/libz.so.1 /usr/glibc-compat/lib/ && \
    /usr/glibc-compat/sbin/ldconfig || ldconfig || true

# 安装中文字体 (文泉驿正黑)
RUN wget -O /tmp/font.tar.gz http://downloads.sourceforge.net/wqy/wqy-zenhei-0.9.45.tar.gz && \
    tar -xzvf /tmp/font.tar.gz -C /tmp/ && \
    mkdir -p /usr/share/fonts/truetype/wqy && \
    cp /tmp/wqy-zenhei/wqy-zenhei.ttc /usr/share/fonts/truetype/wqy/ && \
    fc-cache -f -v && \
    rm -rf /tmp/font.tar.gz /tmp/wqy-zenhei

# 添加文件
COPY rootfs/ /
COPY VERSION /

# 修复换行符 (CRLF -> LF) 并为脚本设置执行权限
# 同时创建 /usr/bin/with-contenv 兼容性脚本 (因为新版 baseimage 移除了它，但 tmm.sh 需要它)
RUN echo '#!/bin/sh' > /usr/bin/with-contenv && \
    echo 'exec "$@"' >> /usr/bin/with-contenv && \
    chmod +x /usr/bin/with-contenv && \
    find /etc/cont-init.d -type f -exec sed -i 's/\r$//' {} \; && \
    find /etc/cont-init.d -type f -exec chmod +x {} \; && \
    if [ -f /startapp.sh ]; then sed -i 's/\r$//' /startapp.sh && chmod +x /startapp.sh; fi

# 设置环境变量
ENV APP_NAME="TinyMediaManager" \
    S6_KILL_GRACETIME=8000

# 定义可挂载目录
VOLUME ["/config"]
VOLUME ["/media"]

# 元数据
LABEL \
    org.label-schema.name="tinymediamanager" \
    org.label-schema.description="Docker container for TinyMediaManager" \
    org.label-schema.version="unknown" \
    org.label-schema.vcs-url="https://github.com/dzhuang/tinymediamanager5-docker" \
    org.label-schema.schema-version="1.0"
