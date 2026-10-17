# The MIT License (MIT)
# Copyright (c) 2025 Mateusz Pusz

# C++ with preconfigured Conan Docker image

# Get the image base
FROM trainiteu/cpp

# Install Conan using pipx (recommended for newer Ubuntu versions)
RUN pipx install conan \
    && conan profile detect --force \
    && conan remote add conan-mpusz https://mpusz.jfrog.io/artifactory/api/conan/conan-oss

# Add Conan configuration, owned by the user so that Conan can update it
COPY --chown=${DOCKER_USER_NAME}:${DOCKER_USER_NAME} conan $CONAN_HOME

# Every installed compiler has a Conan profile, and every profile has its compiler
COPY check-conan-profiles /usr/local/bin/
RUN check-conan-profiles
