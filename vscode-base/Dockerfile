# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.145.0/containers/ubuntu/.devcontainer/base.Dockerfile

# Get the image base
FROM mcr.microsoft.com/vscode/devcontainers/base:0-focal

COPY install-packages /usr/bin

RUN install-packages \
        build-essential \
        software-properties-common

ENV DOCKER_USER_NAME=root
ENV HOME=/root
ENV CONAN_USER_HOME=$HOME
