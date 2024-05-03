FROM alpine:latest
WORKDIR /tmp

# edge repo is required for terraform
RUN apk add --no-cache \
	--repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
	firefox \
	openvpn \
	py3-pip \
	terraform \
	ttf-dejavu ttf-liberation \
    openssh-client \
	sshpass \
	su-exec

RUN ln -s python3 /usr/bin/python

RUN apk add sudo
RUN echo '%wheel ALL = NOPASSWD: ALL' > /etc/sudoers.d/wheel

COPY scripts/ /usr/local/bin
COPY entrypoint /sbin

# Add un-privilged user or X clients can't be run
ARG uid=uid
ARG user=user
ENV UID=$uid
ENV USER=$user

RUN adduser -u ${UID} -G wheel -D ${USER}

ENTRYPOINT /sbin/entrypoint

