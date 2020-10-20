# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.145.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install needed packages. Use a separate RUN statement to add your own dependencies.
RUN sudo apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y upgrade \
    && sudo apt-get -y install build-essential g++-10 cmake ninja-build pkg-config gdb cppcheck valgrind 
    
# Install the clang 11
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y install --no-install-recommends software-properties-common \
    && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - \
    && sudo add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-11 main" \
    && sudo apt-get -y install clang-11 clang-tools-11 clang-11-doc libclang-common-11-dev libclang-11-dev libclang1-11 clang-format-11 clangd-11 libc++-11-dev libc++abi-11-dev libfuzzer-11-dev lldb-11 lld-11

# Install Conan.
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y install --no-install-recommends python3-pip \
    && pip3 install -U conan \
    && conan user \
    && conan remote add conan-mpusz https://api.bintray.com/conan/mpusz/conan-mpusz \
    && conan remote add conan-train-it https://api.bintray.com/conan/train-it/conan-train-it
ADD conan /root/.conan

# Add common CMake scripts
ADD cmake /root/cmake

# Predefine VSCode CMake kits
ADD CMakeTools /root/.local/share/CMakeTools

# Clean apt for docker image.
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get autoremove -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/*

# [Optional] Uncomment this section to install additional OS packages.
# RUN sudo apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && sudo apt-get -y install --no-install-recommends packages...
