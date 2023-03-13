ARG UBUNTU_BASE=kinetic

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
    wget

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

ENV DOCKER_USER_NAME=gitpod
ENV HOME=/home/${DOCKER_USER_NAME}
ENV PYTHONUSERBASE=/workspace/.pip-modules
ENV PATH="${PYTHONUSERBASE}/bin:${PATH}"
ENV CONAN_USER_HOME=/workspace

RUN sudo mkdir ${CONAN_USER_HOME} \
    && sudo chown ${DOCKER_USER_NAME}:${DOCKER_USER_NAME} ${CONAN_USER_HOME}

### Gitpod user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u 33333 -G sudo -md ${HOME} -s /bin/bash -p ${DOCKER_USER_NAME} ${DOCKER_USER_NAME} \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 \" (%s)\") $ '" ; } >> .bashrc

### Gitpod user (2) ###
USER ${DOCKER_USER_NAME}
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir -p ${HOME}/.bashrc.d && \
    (echo; echo "for i in \$(ls -A \$HOME/.bashrc.d/); do source \$HOME/.bashrc.d/\$i; done"; echo) >> ${HOME}/.bashrc

# configure git-lfs
RUN sudo git lfs install --system
