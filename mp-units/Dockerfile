# The MIT License (MIT)
# Copyright (c) 2018 Mateusz Pusz

# Docker image for mp-units development environment

FROM trainiteu/cpp-conan

# Add Conan configuration for additional compilers, owned by the user so that Conan can update it.
# It comes before the compiler setup, which points each clang profile at that compiler's real
# binary path.
COPY --chown=${DOCKER_USER_NAME}:${DOCKER_USER_NAME} conan $CONAN_HOME

# The mp-units compiler matrix (GCC 12-16, clang 16-18 and 20-24, each clang with its own static
# libc++) is set up by the same script that sets up a developer's own machine, so the two cannot
# drift apart. See the script's header for why apt alone cannot provide the per-version libc++.
ADD https://raw.githubusercontent.com/mpusz/mp-units/master/.devcontainer/setup_compilers.sh /tmp/setup_compilers.sh
RUN sudo bash /tmp/setup_compilers.sh \
  && sudo rm -rf /tmp/setup_compilers.sh /var/lib/apt/lists/*

RUN sudo install-packages \
  # ProperDocs (Material for MkDocs imaging) dependencies
  libcairo2-dev \
  libfreetype6-dev \
  libffi-dev \
  libjpeg-dev \
  libpng-dev \
  libz-dev \
  # markdownlint-cli2 and other Node-based pre-commit hooks
  nodejs \
  npm

# Configure Conan remote with pre-built mp-units dependencies
RUN conan remote add conan-mp-units-dev https://mpusz.jfrog.io/artifactory/api/conan/conan-mp-units-dev

# Install additional Python tools required for mp-units development
RUN pipx install pre-commit \
  && pipx install identify \
  && pipx install properdocs \
  && pipx inject properdocs mkdocs-material[imaging] mkdocs-rss-plugin mkdocs-redirects \
  && pipx inject --include-apps properdocs mike

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR ${WORKSPACES}

# Every installed compiler has a Conan profile, and every profile has its compiler
RUN check-conan-profiles
