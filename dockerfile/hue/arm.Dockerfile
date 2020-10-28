FROM openeuler-20.09-arm:latest as build

LABEL org.opencontainers.image.source="https://github.com/ZhengZhenyu/kube-LooKeng/dockerfile"
LABEL maintainer="zheng.zhenyu@outlook.com"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN sed -i s'/TMOUT=300/TMOUT=3000000000/' /etc/bashrc

WORKDIR /opt/hue
RUN sudo yum -y install python3-devel libffi-devel gcc-c++ ant asciidoc cyrus-sasl-devel cyrus-sasl-gssapi  krb5-devel libtidy libxml2-devel libxslt-devel openldap-devel sqlite-devel openssl-devel mysql-devel gmp-devel maven wget
RUN git clone https://github.com/cloudera/hue.git && git checkout release-4.8.0
RUN git cherry-pick 7a9100d4a7f38eaef7bd4bd7c715ac1f24a969a8
RUN git cherry-pick e67c1105b85b815346758ef1b9cd714dd91d7ea3
ENV PYTHON_VER python3.8
RUN cd hue && PREFIX=/usr/share make install
