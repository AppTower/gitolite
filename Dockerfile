FROM alpine

ARG USERNAME=git
ARG VERSION=v3.6.8

RUN apk update \
    && apk upgrade \
    && apk add --no-cache git perl openssh-server \
    && mkdir -p /var/run/sshd \
    && chmod 0755 /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config

RUN git clone https://github.com/sitaramc/gitolite.git /tmp/gitolite \
    && git --git-dir=/tmp/gitolite/.git --work-tree=/tmp/gitolite checkout -fq $VERSION \
    && /tmp/gitolite/install -to /usr/bin \
    && rm -rf /tmp/gitolite 

RUN adduser --home /home/$USERNAME --shell /bin/sh --disabled-password $USERNAME $USERNAME \
    && passwd -u $USERNAME

VOLUME /home/$USERNAME

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 22
CMD ["/bin/sh"]
