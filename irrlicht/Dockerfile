FROM trainiteu/cpp

# Install workshop's dependencies.
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends libgl1-mesa-dev libxcursor-dev libxxf86vm-dev libxext-dev

# Update Conan configuration for the workshop
RUN sed -i -r 's/cppstd=([[:digit:]]+)/cppstd=gnu\1/' /root/.conan/profiles/*

# Clean apt for docker image.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends packages...
