# Base image to use: gitpod, vscode
ARG BASE_IMAGE

# Get the image base
FROM trainiteu/${BASE_IMAGE}-base

# Tool versions
ARG GCC_VERSION=13
ARG CLANG_VERSION=17
ARG CMAKE_VERSION=3.28.1

USER root

# Install needed packages
RUN install-packages \
    g++-${GCC_VERSION} \
    ninja-build \
    gdb \
    cppcheck \
    valgrind \
    python3-pip \
    python-is-python3 \
    # needed to build CMake
    libssl-dev

# Install Clang
RUN lsb_rel=`lsb_release -cs` \
    && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - \
    && add-apt-repository "deb http://apt.llvm.org/${lsb_rel}/ llvm-toolchain-${lsb_rel}-${CLANG_VERSION} main" \
    && install-packages \
    clang-${CLANG_VERSION} \
    clang-tools-${CLANG_VERSION} \
    clang-${CLANG_VERSION}-doc \
    libclang-common-${CLANG_VERSION}-dev \
    libclang-${CLANG_VERSION}-dev \
    libclang1-${CLANG_VERSION} \
    clang-format-${CLANG_VERSION} \
    clangd-${CLANG_VERSION} \
    libc++-${CLANG_VERSION}-dev \
    libc++abi-${CLANG_VERSION}-dev \
    libunwind-${CLANG_VERSION}-dev \
    libfuzzer-${CLANG_VERSION}-dev \
    lldb-${CLANG_VERSION} \
    lld-${CLANG_VERSION}

# Set default compilers
ENV CC=/usr/bin/gcc-${GCC_VERSION}
ENV CXX=/usr/bin/g++-${GCC_VERSION}

# Download, build, and install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    && tar -xvzf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap --parallel=$(nproc) --generator=Ninja\
    && ninja \
    && ninja install \
    && cd .. \
    && rm -rf cmake-${CMAKE_VERSION}*

# Set a default CMake generator
ENV CMAKE_GENERATOR="Ninja Multi-Config"
