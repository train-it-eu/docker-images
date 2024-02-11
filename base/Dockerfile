ARG UBUNTU_BASE=mantic

FROM ubuntu:${UBUNTU_BASE}

COPY install-packages /usr/bin

### base ###
ARG DEBIAN_FRONTEND=noninteractive

RUN yes | unminimize

RUN install-packages \
    zip \
    unzip \
    bash-completion \
    build-essential \
    git \
    git-lfs \
    gpg-agent \
    htop \
    less \
    locales \
    man-db \
    software-properties-common \
    sudo \
    time \
    ssl-cert \
    wget \
    python3-venv

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

ENV PYTHON_VENV=/workspace/.pip
ENV PATH="${PYTHON_VENV}/bin:${PATH}"
ENV CONAN_HOME=/workspace/.conan2

# configure git-lfs
RUN sudo git lfs install --system
