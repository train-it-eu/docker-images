FROM trainiteu/cpp-base

# Install Conan
RUN export DEBIAN_FRONTEND=noninteractive \
    && pip3 install -U conan \
    && conan user \
    && conan remote add conan-mpusz https://api.bintray.com/conan/mpusz/conan-mpusz \
    && conan remote add conan-train-it https://api.bintray.com/conan/train-it/conan-train-it

# Add Conan profiles
ADD conan /root/.conan

# Set a default CMake generator
ENV CMAKE_GENERATOR=Ninja Multi-Config

# Add common CMake scripts
ADD cmake /root/cmake

# Predefine VSCode CMake kits
ADD CMakeTools /root/.local/share/CMakeTools

# [Optional] Uncomment this section to install additional OS packages.
# RUN sudo apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && sudo apt-get -y install --no-install-recommends packages...
