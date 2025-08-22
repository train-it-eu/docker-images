ARG UBUNTU_BASE=plucky

FROM ubuntu:${UBUNTU_BASE}

COPY install-packages /usr/bin

### base ###
ARG DEBIAN_FRONTEND=noninteractive

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
    # Security and certificates
    ca-certificates \
    gnupg \
    # Python virtual environment support
    python3-venv

ENV DOCKER_USER_NAME=ubuntu
ENV DOCKER_BUILDKIT=1
ENV HOME=/home/${DOCKER_USER_NAME}
ENV CONAN_HOME=/workspaces/.conan2

# Create workspaces directory and set permissions
RUN mkdir -p /workspaces \
    && chown -R ${DOCKER_USER_NAME}:${DOCKER_USER_NAME} /workspaces

# configure git-lfs
RUN sudo git lfs install --system

# passwordless sudo for users in the 'sudo' group
RUN sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

WORKDIR $HOME

# custom Bash prompt
RUN { echo && echo "PS1='\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 \" (%s)\") $ '" ; } >> .bashrc
