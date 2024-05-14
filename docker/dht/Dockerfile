# 使用官方的 Python 镜像作为基础镜像
FROM python:3.12-slim

# 更新软件包列表并安装必要的软件包
RUN apt update && apt install -y \
  python3-pip \
  python3-venv \
  python-is-python3 \
  && apt clean

# 设置工作目录
WORKDIR /app

# 创建虚拟环境
RUN python3 -m venv /app/myenv

# 激活虚拟环境并安装 petals 包
RUN /app/myenv/bin/pip install --upgrade pip \
  && /app/myenv/bin/pip install git+https://github.com/bigscience-workshop/petals

# 复制本地文件到容器中
COPY . /app

# 设置环境变量以使用虚拟环境中的 Python 和 pip
ENV PATH="/app/myenv/bin:$PATH"

# 设置环境变量
ENV INITIAL_PEERS=""

# 运行 petals DHT 并输出日志到标准输出
CMD ["sh", "-c", "exec python3 -m petals.cli.run_dht --host_maddrs /ip4/0.0.0.0/tcp/31337 --identity_path /home/bootstrap1.id ${INITIAL_PEERS:+--initial_peers $INITIAL_PEERS}"]
