# The MIT License (MIT)
# Copyright (c) 2018 Mateusz Pusz

# Docker image for mp-units development environment

FROM trainiteu/cpp-conan

# Add additional LLVM repositories for mp-units compilation verification
USER root
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm-snapshot.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main" >> /etc/apt/sources.list.d/llvm-jammy-16.list

# Install additional compilers and tools for mp-unit development
RUN install-packages \
  g++-12 g++-13 \
  clang-16 clang-17 clang-18 clang-19

USER ${DOCKER_USER_NAME}

# Add Conan configuration for additional compilers
ADD conan $CONAN_HOME

# Install additional Python tools required for mp-units development
RUN pipx install pre-commit \
  && pipx install identify \
  && pipx install mkdocs \
  && pipx inject mkdocs mkdocs-material[imaging] mkdocs-rss-plugin mkdocs-exclude \
  && pipx install mike
