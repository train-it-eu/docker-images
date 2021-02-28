# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.145.0/containers/ubuntu/.devcontainer/base.Dockerfile

# Ubuntu version: bionic, focal
ARG UBUNTU_VERSION=focal

# Get the image base
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${UBUNTU_VERSION}

# Tool versions
ARG GCC_VERSION=10
ARG CLANG_VERSION=12
ARG CMAKE_VERSION=3.19.6

# Install needed packages
RUN sudo apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y upgrade \
    && sudo apt-get -y install build-essential g++-${GCC_VERSION} ninja-build pkg-config gdb cppcheck valgrind python3-pip

# Install Clang
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y install --no-install-recommends software-properties-common \
    && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - \
    && sudo add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-${CLANG_VERSION} main" \
    && sudo apt-get -y install clang-${CLANG_VERSION} clang-tools-${CLANG_VERSION} clang-${CLANG_VERSION}-doc libclang-common-${CLANG_VERSION}-dev libclang-${CLANG_VERSION}-dev libclang1-${CLANG_VERSION} clang-format-${CLANG_VERSION} clangd-${CLANG_VERSION} libc++-${CLANG_VERSION}-dev libc++abi-${CLANG_VERSION}-dev libfuzzer-${CLANG_VERSION}-dev lldb-${CLANG_VERSION} lld-${CLANG_VERSION}

# Set default compilers
ENV CC=/usr/bin/gcc-${GCC_VERSION}
ENV CXX=/usr/bin/g++-${GCC_VERSION}

# Download, build, and install CMake
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends libssl-dev \
    && apt-get -y remove --purge cmake \
    && wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    && tar -xvzf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap --parallel=$(nproc) --generator=Ninja\
    && ninja \
    && ninja install \
    && cd .. \
    && rm -rf cmake-${CMAKE_VERSION}*

# Clean apt for docker image
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get autoremove -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/*

# [Optional] Uncomment this section to install additional OS packages.
# RUN sudo apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && sudo apt-get -y install --no-install-recommends packages...
