FROM ghcr.io/zhengzhenyu/openeuler2009-arm

LABEL maintainer="zheng.zhenyu@outlook.com"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN yum update -y \
    && yum install -y python2 java-1.8.0-openjdk-devel wget tar

RUN wget https://download.openlookeng.io/1.0.1/hetu-server-1.0.1.tar.gz
RUN tar -xzvf hetu-server-1.0.1.tar.gz

