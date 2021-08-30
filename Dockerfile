# syntax = docker/dockerfile:experimental
FROM --platform=$TARGETPLATFORM ubuntu

COPY   *.c /tmp/

COPY   install.sh /tmp/
RUN    bash /tmp/install.sh

COPY   install2.sh /tmp/
RUN    bash /tmp/install2.sh

RUN --mount=type=bind,source=move2docker,target=/tmp/move2docker rsync -a --no-perms --no-owner --no-group --chmod=755 --keep-dirlinks /tmp/move2docker/* /;

ENV EDITOR vim \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENTRYPOINT ["/sbin/runit-docker"]

