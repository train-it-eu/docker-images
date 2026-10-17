# The MIT License (MIT)
# Copyright (c) 2025 Mateusz Pusz

# Basic Ubuntu Docker image

ARG UBUNTU_BASE=resolute

FROM ubuntu:${UBUNTU_BASE}

ENV DOCKER_USER_NAME=ubuntu
ENV HOME=/home/${DOCKER_USER_NAME}
ENV WORKSPACES=/workspaces

ARG DEBIAN_FRONTEND=noninteractive
COPY install-packages /usr/bin
RUN install-packages \
    # Archive utilities for handling compressed files
    zip \
    unzip \
    # Enhanced bash shell with completion
    bash-completion \
    # Essential compilation tools (gcc, make, etc.)
    build-essential \
    # Version control
    git \
    git-lfs \
    # System administration
    sudo \
    # Network tools for downloading
    wget \
    curl \
    # Verification of HTTPS servers and signed apt repositories
    ca-certificates \
    gnupg \
    # Python virtual environment support
    python3-venv


# passwordless sudo for users in the 'sudo' group
RUN echo '%sudo ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/nopasswd \
    && chmod 0440 /etc/sudoers.d/nopasswd \
    && visudo -cf /etc/sudoers.d/nopasswd

USER ${DOCKER_USER_NAME}

# configure git-lfs
RUN git lfs install --system

# Create workspaces directory and set permissions
RUN sudo mkdir -p ${WORKSPACES} && sudo chown -R ${DOCKER_USER_NAME}:${DOCKER_USER_NAME} ${WORKSPACES}

# custom Bash prompt
RUN { echo && echo "PS1='\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 \" (%s)\") $ '" ; } >> ~/.bashrc

WORKDIR ${WORKSPACES}
