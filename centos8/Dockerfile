FROM centos:centos8

ARG CMAKE_VERSION=3.20.2

# Install needed packages
RUN dnf clean all && dnf -y upgrade && dnf -y update 
RUN dnf -y install openssh-server passwd sudo patch git wget

# Prepare SSH server
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN rm -rf /run/nologin

# Install C++ development environement
RUN dnf -y install python3 epel-release gcc gcc-c++
RUN dnf --enablerepo=powertools -y install ninja-build
RUN dnf --enablerepo=epel -y install ccache
RUN pip3 install conan

# Download, build, and install CMake
RUN dnf -y install openssl-devel \
    && wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    && tar -xvzf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap --parallel=$(nproc) --generator=Ninja\
    && ninja \
    && ninja install \
    && cd .. \
    && rm -rf cmake-${CMAKE_VERSION}*

RUN dnf clean all

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
