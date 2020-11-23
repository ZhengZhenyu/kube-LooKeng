FROM ghcr.io/zhengzhenyu/openeuler2009-arm

LABEL maintainer="zheng.zhenyu@outlook.com"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN yum update -y \
    && yum install -y python2 java-1.8.0-openjdk-devel tar shadow-utils sudo

RUN groupadd openlkadmin
RUN useradd -m -d /home/openlkadmin -s /bin/bash openlkadmin -g openlkadmin
RUN echo "openlkadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /opt/openlookeng && chown openlkadmin:openlkadmin /opt/openlookeng

USER openlkadmin
WORKDIR /home/openlkadmin

RUN curl -L https://github.com/ZhengZhenyu/hetu-core/releases/download/UI_new/hetu-server-1.0.0-SNAPSHOT.tar.gz | tar zx
RUN ln -s hetu-server-1.0.0-SNAPSHOT/ hetu-server

COPY --chown=openlkadmin:openlkadmin entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /home/openlkadmin/hetu-server
RUN mkdir -p etc etc/catalog
COPY --chown=openlkadmin:openlkadmin node.properties etc/node.properties
COPY --chown=openlkadmin:openlkadmin config.properties etc/config.properties
COPY --chown=openlkadmin:openlkadmin jvm.config etc/jvm.config
COPY --chown=openlkadmin:openlkadmin log.properties etc/log.properties

RUN echo "node.id=$(cat /proc/sys/kernel/random/uuid)" >> etc/node.properties

ENV TZ Asia/Hong_Kong

ENTRYPOINT ["/entrypoint.sh"]
