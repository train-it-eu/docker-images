# Base image to use: gitpod, vscode
ARG BASE_IMAGE

# Get the image base
FROM trainiteu/${BASE_IMAGE}-cpp

USER ${DOCKER_USER_NAME}

# Install Conan
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo pip3 install -U conan \
    && conan profile detect \
    && conan remote add conan-mpusz https://mpusz.jfrog.io/artifactory/api/conan/conan-oss

# Add Conan profiles
ADD --chown=${DOCKER_USER_NAME}:${DOCKER_USER_NAME} conan $CONAN_USER_HOME/.conan2

# Set initial VSCode configuration for Conan usage
COPY --chown=${DOCKER_USER_NAME}:${DOCKER_USER_NAME} vscode/settings.json $HOME/.vscode-server/data/Machine/settings.json

USER root
