# The MIT License (MIT)
# Copyright (c) 2025 Mateusz Pusz

# C++ with preconfigured Conan Docker image

# Get the image base
FROM trainiteu/cpp

# Install Conan using pipx (recommended for newer Ubuntu versions)
RUN pipx install conan \
    && conan profile detect --force \
    && conan remote add conan-mpusz https://mpusz.jfrog.io/artifactory/api/conan/conan-oss

# Add Conan configuration
ADD conan $CONAN_HOME
