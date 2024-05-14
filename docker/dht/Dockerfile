# 使用基础镜像
FROM ubuntu:20.04

# 设置维护者信息
LABEL maintainer="fangyemingzz@gmaill.com"

# 设置工作目录
WORKDIR /home

# 设置语言环境
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# 更新apt并安装必要的软件包
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  wget \
  git \
  python3 \
  python3-pip \
  && apt-get clean autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 安装Petals及其依赖
RUN python3 -m pip install git+https://github.com/xfangs/petals.git && \
  python3 -m pip install tokenizers==0.14.1 transformers -U

# 复制identity文件到工作目录（确保该文件存在于您的上下文中）
#COPY bootstrap1.id /home/bootstrap1.id

# 设置环境变量
ENV INITIAL_PEERS=""

# 设置默认命令
CMD ["sh", "-c", "exec python3 -m petals.cli.run_dht --host_maddrs /ip4/0.0.0.0/tcp/31337 --identity_path /home/bootstrap1.id --initial_peers $INITIAL_PEERS"]
