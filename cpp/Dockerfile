# The MIT License (MIT)
# Copyright (c) 2025 Mateusz Pusz

# C++ development Docker image

# Get the image base
FROM trainiteu/ubuntu

# Tool versions
ARG GCC_VERSION=15
ARG CLANG_VERSION=21
ARG CMAKE_VERSION=4.1.0

ENV CONAN_HOME=${HOME}/.conan2
ENV PIPX_HOME=${HOME}/.pipx
ENV PIPX_BIN_DIR=${HOME}/.local/bin
ENV PATH="${PIPX_BIN_DIR}:${PATH}"

# Create pipx directories and set permissions
RUN mkdir -p ${PIPX_HOME} ${PIPX_BIN_DIR}

# Install needed packages
RUN sudo install-packages \
    # C++ compiler (latest version)
    g++-${GCC_VERSION} \
    # Fast build system
    ninja-build \
    # Debugging tools
    gdb \
    # Static analysis
    cppcheck \
    # Memory debugging and profiling
    valgrind \
    # Python package installers
    python3-pip \
    python-is-python3 \
    # Modern Python tool installer (isolated environments)
    pipx \
    # SSL development headers (needed to build CMake)
    libssl-dev \
    # Required by LLVM installation script
    lsb-release \
    software-properties-common

# Install the latest Clang packages
RUN wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && sudo ./llvm.sh ${CLANG_VERSION} \
    && rm llvm.sh

# Install additional LLVM-related packages
RUN sudo install-packages \
    # Additional Clang tools (clang-tidy, etc.)
    clang-tools-${CLANG_VERSION} \
    # Code formatter
    clang-format-${CLANG_VERSION} \
    # Modern C++ standard library
    libc++-${CLANG_VERSION}-dev \
    libc++abi-${CLANG_VERSION}-dev

# Set default compilers
ENV CC=/usr/bin/gcc-${GCC_VERSION}
ENV CXX=/usr/bin/g++-${GCC_VERSION}

# Create convenient compiler aliases
RUN sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 \
    && sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100 \
    && sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100 \
    && sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100 \
    && sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${CLANG_VERSION} 100

# Download, build, and install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    && tar -xvzf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap --parallel=$(nproc) --generator=Ninja\
    && ninja \
    && sudo ninja install \
    && cd .. \
    && rm -rf cmake-${CMAKE_VERSION}*

# Set a default CMake generator
ENV CMAKE_GENERATOR="Ninja Multi-Config"
