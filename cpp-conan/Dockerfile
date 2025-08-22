# Get the image base
FROM trainiteu/cpp

USER ${DOCKER_USER_NAME}

# Install Conan using pipx (recommended for newer Ubuntu versions)
RUN pipx install conan \
    && conan profile detect --force \
    && conan remote add conan-mpusz https://mpusz.jfrog.io/artifactory/api/conan/conan-oss

# Add Conan configuration
ADD --chown=${DOCKER_USER_NAME}:${DOCKER_USER_NAME} conan $CONAN_HOME

USER root
