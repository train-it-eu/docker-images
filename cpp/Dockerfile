# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.145.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install needed packages. Use a separate RUN statement to add your own dependencies.
RUN sudo apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y upgrade \
    && sudo apt-get -y install build-essential g++-10 cmake ninja-build pkg-config gdb cppcheck valgrind clang clang-tools clang-format clang-tidy libc++-dev lldb

# Install Conan.
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y install --no-install-recommends python3-pip \
    && pip3 install -U conan \
    && conan user \
    && conan remote add conan-mpusz https://api.bintray.com/conan/mpusz/conan-mpusz \
    && conan remote add conan-train-it https://api.bintray.com/conan/train-it/conan-train-it
ADD .conan /root/.conan

# Add common CMake scripts
ADD cmake /root/cmake

# Clean apt for docker image.
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get autoremove -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/*

# [Optional] Uncomment this section to install additional OS packages.
# RUN sudo apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && sudo apt-get -y install --no-install-recommends packages...
