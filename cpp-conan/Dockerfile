# Base image to use: gitpod, vscode
ARG BASE_IMAGE

# Get the image base
FROM trainiteu/${BASE_IMAGE}-cpp

USER ${DOCKER_USER_NAME}

RUN sudo mkdir /workspace \
    && sudo chown ${DOCKER_USER_NAME}:${DOCKER_USER_NAME} /workspace

# Install Conan
RUN export DEBIAN_FRONTEND=noninteractive \
    && sudo pip3 install -U conan \
    && conan config init \
    && conan remote add -i 0 conan-mpusz https://mpusz.jfrog.io/artifactory/api/conan/conan-oss
    # && conan remote add conan-train-it https://api.bintray.com/conan/train-it/conan-train-it

# Add Conan profiles
ADD conan $CONAN_USER_HOME/.conan

# Set initial VSCode configuration for Conan usage
COPY vscode/settings.json $HOME/.config/Code/User/settings.json
