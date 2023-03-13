# See here for image contents: https://github.com/devcontainers/images/tree/main/src/base-ubuntu

# Get the image base
FROM mcr.microsoft.com/devcontainers/base:ubuntu
USER root

COPY install-packages /usr/bin

RUN install-packages \
        build-essential \
        software-properties-common

ENV DOCKER_USER_NAME=vscode
ENV HOME=/home/${DOCKER_USER_NAME}
ENV PROJECT_PATH=/workspaces
ENV CONAN_USER_HOME=$HOME
