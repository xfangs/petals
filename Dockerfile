FROM nvcr.io/nvidia/cuda:11.0.3-cudnn8-devel-ubuntu20.04
LABEL maintainer="bigscience-workshop"
LABEL repository="petals"

WORKDIR /home
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  wget \
  git \
  && apt-get clean autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O install_miniconda.sh && \
  bash install_miniconda.sh -b -p /opt/conda && rm install_miniconda.sh
ENV PATH="/opt/conda/bin:${PATH}"

RUN conda install python~=3.10.12 pip && \
  pip install --no-cache-dir "torch>=1.12" transformers huggingface_hub huggingface-cli && \
  conda clean --all && rm -rf ~/.cache/pip

VOLUME /cache
ENV PETALS_CACHE=/cache
ENV HF_TOKEN=""
ENV INITIAL_PEERS=""

COPY . petals/
RUN pip install --no-cache-dir -e petals

WORKDIR /home/petals/
CMD ["python", "-m", "petals.cli.run_server", "--initial_peers", "${INITIAL_PEERS}"]
