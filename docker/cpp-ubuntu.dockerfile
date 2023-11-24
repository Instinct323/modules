# docker build -f cpp-ubuntu.dockerfile -t cpp-base .
# docker run -p 22:22 cpp-base
# docker exec -it <ctn> bash

FROM ubuntu:18.04
MAINTAINER TongZJ

RUN useradd -m tongzj
RUN echo 'tongzj:20010323' | chpasswd

# apt-get
RUN apt-get update
RUN apt-get install -y wget unzip tree
WORKDIR /home/tongzj

# Git
RUN apt-get install -y git
RUN git config --global user.name 'TongZJ'
RUN git config --global user.email '1400721986@qq.com'

# OpenSSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# C++ toolchain
RUN apt-get install -y build-essential gdb net-tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

# CMake
ARG BIN=/usr/bin

COPY cmake-build.bash $BIN/cmake-build
RUN chmod +x $BIN/cmake-build

COPY cmake-install.bash $BIN/cmake-install
RUN chmod +x $BIN/cmake-build

CMD /usr/sbin/sshd -D
