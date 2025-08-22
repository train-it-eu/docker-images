# Get the image base
FROM trainiteu/ubuntu

# Tool versions
ARG GCC_VERSION=15
ARG CLANG_VERSION=20
ARG CMAKE_VERSION=4.1.0

USER root

# Install Python apps to a path that gets mounted as persistent storage
ENV PIPX_HOME=/workspaces/.pipx
ENV PIPX_BIN_DIR=/workspaces/.local/bin
ENV PATH="/workspaces/.local/bin:${PATH}"

# Create pipx directories and set permissions
RUN mkdir -p /workspaces/.pipx /workspaces/.local/bin \
    && chown -R ${DOCKER_USER_NAME}:${DOCKER_USER_NAME} /workspaces/.pipx /workspaces/.local/bin

# Install needed packages
RUN install-packages \
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

# Install Clang
RUN wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh ${CLANG_VERSION} \
    && install-packages \
    # Core Clang compiler
    clang-${CLANG_VERSION} \
    # Additional Clang tools (clang-tidy, etc.)
    clang-tools-${CLANG_VERSION} \
    # Code formatter
    clang-format-${CLANG_VERSION} \
    # Language Server Protocol implementation for IDEs
    clangd-${CLANG_VERSION} \
    # Modern C++ standard library
    libc++-${CLANG_VERSION}-dev \
    libc++abi-${CLANG_VERSION}-dev \
    # Fast linker (alternative to GNU ld)
    lld-${CLANG_VERSION}

# Set default compilers
ENV CC=/usr/bin/gcc-${GCC_VERSION}
ENV CXX=/usr/bin/g++-${GCC_VERSION}

# Create convenient compiler aliases
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100 \
    && update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${CLANG_VERSION} 100

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
