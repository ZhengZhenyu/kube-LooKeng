FROM ghcr.io/zhengzhenyu/openeuler2009-arm

LABEL maintainer="zheng.zhenyu@outlook.com"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN yum update -y \
    && yum install -y python2 java-1.8.0-openjdk-devel tar shadow-utils

RUN groupadd openlkadmin
RUN useradd -m -d /home/openlkadmin -s /bin/bash openlkadmin -g openlkadmin
RUN echo "openlkadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER openlkadmin
WORKDIR /home/openlkadmin

RUN curl -L https://download.openlookeng.io/1.0.1/hetu-server-1.0.1.tar.gz | tar zx

