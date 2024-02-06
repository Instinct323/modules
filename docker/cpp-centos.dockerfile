# docker build -f cpp-centos.dockerfile -t cpp-base .
# docker run -p 22:22 cpp-base
# docker exec -it <ctn> bash

FROM centos:7

ARG USER=tongzj
ARG PASSWD='20010323'
ARG EMAIL='1400721986@qq.com'
# InComplete

# yum, wget
RUN yum install -y wget && \
    wget http://mirrors.aliyun.com/repo/Centos-7.repo -P /etc/yum.repos.d

# Git
RUN apt install -y git && \
    git config --global user.name $USER && \
    git config --global user.email $EMAIL

# OpenSSH
RUN yum install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

WORKDIR /home/$USER
CMD /usr/sbin/sshd -D
