# 使用基础镜像
FROM ubuntu:20.04

# 设置维护者信息
LABEL maintainer="fangyemingzz@gmail.com"

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
  && apt-get clean autoclean && rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# 安装Python依赖
RUN python3 -m pip install --no-cache-dir "torch>=1.12" git+https://github.com/HyperdustLab/petals

# 设置工作目录为petals目录
WORKDIR /home/petals

# 设置默认命令
CMD ["python3", "-m", "petals.cli.run_dht", "--host_maddrs", "/ip4/0.0.0.0/tcp/31337", "--identity_path", "bootstrap1.id"]
