FROM trainiteu/vscode-cpp-conan

# Install workshop's dependencies
RUN install-packages \
    libgl1-mesa-dev \
    libxcursor-dev \
    libxxf86vm-dev \
    libxext-dev

# Update Conan configuration for the workshop
RUN sed -i -r 's/cppstd=([[:digit:]]+)/cppstd=gnu\1/' ${CONAN_HOME}/profiles/*
