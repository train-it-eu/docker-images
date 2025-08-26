# The MIT License (MIT)
# Copyright (c) 2018 Mateusz Pusz

# Docker image for mp-units development environment

FROM trainiteu/cpp-conan

# Add additional LLVM repositories for mp-units compilation verification
USER root
RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm-snapshot.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main" >> /etc/apt/sources.list.d/llvm-jammy-16.list

# Install additional compilers and tools for mp-units development
# (g++-14, g++-15, and clang-20 are installed in cpp image already)
RUN install-packages \
  g++-12 g++-13 \
  # install jammy packages from the LLVM apt repository
  clang-16 clang-tools-16 \
  # install from the Ubuntu universe apt repository
  clang-17 clang-tools-17 \
  clang-18 clang-tools-18 \
  clang-19 clang-tools-19 \
  # switch to libc++-18 as this is the last version supporting clang-16
  libc++-18-dev \
  # mkdocs dependencies
  libcairo2-dev \
  libfreetype6-dev \
  libffi-dev \
  libjpeg-dev \
  libpng-dev \
  libz-dev \
  # API reference dependencies
  latexmk \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-fonts-recommended \
  lmodern \
  haskell-stack \
  graphviz \
  nodejs \
  npm \
  ghc \
  cabal-install

# Expose libc++-18 modules to all the versions of clang compilers
RUN sudo ln -s /usr/lib/llvm-18/lib/libc++.modules.json /usr/lib/llvm-16/lib/libc++.modules.json && \
  sudo ln -s /usr/lib/llvm-18/share/libc++ /usr/lib/llvm-16/share/libc++ && \
  sudo ln -s /usr/lib/llvm-18/lib/libc++.modules.json /usr/lib/llvm-17/lib/libc++.modules.json && \
  sudo ln -s /usr/lib/llvm-18/share/libc++ /usr/lib/llvm-17/share/libc++ && \
  sudo ln -s /usr/lib/llvm-18/lib/libc++.modules.json /usr/lib/llvm-19/lib/libc++.modules.json && \
  sudo ln -s /usr/lib/llvm-18/share/libc++ /usr/lib/llvm-19/share/libc++ && \
  sudo ln -s /usr/lib/llvm-18/lib/libc++.modules.json /usr/lib/llvm-20/lib/libc++.modules.json && \
  sudo ln -s /usr/lib/llvm-18/share/libc++ /usr/lib/llvm-20/share/libc++

USER ${DOCKER_USER_NAME}

# Add Conan configuration for additional compilers
ADD conan $CONAN_HOME

# Configure Conan remote with pre-built mp-units dependencies
RUN conan remote add conan-mp-units-dev https://mpusz.jfrog.io/artifactory/api/conan/conan-mp-units-dev

# Install additional Python tools required for mp-units development
RUN pipx install pre-commit \
  && pipx install identify \
  && pipx install mkdocs \
  && pipx inject mkdocs mkdocs-material[imaging] mkdocs-rss-plugin mkdocs-exclude \
  && pipx install mike

WORKDIR ${WORK_DIR}

# Install additional tools for API reference generation
ENV PATH="${WORK_DIR}/node_modules/.bin:${PATH}"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN npm install split mathjax-full mathjax-node-sre mathjax-node-cli yargs@16.2.0
RUN cabal update
RUN tlmgr init-usertree && tlmgr install ulem
