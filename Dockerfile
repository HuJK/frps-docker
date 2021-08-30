# syntax = docker/dockerfile:experimental
FROM --platform=$TARGETPLATFORM ubuntu as builder

COPY   *.c /tmp/

COPY   install_builder.sh /tmp/
RUN    bash /tmp/install_builder.sh

FROM --platform=$TARGETPLATFORM ubuntu as syncer

COPY   install_syncer.sh /tmp/
RUN    bash /tmp/install_syncer.sh
COPY --from=0 /lib/runit-docker.so /lib/runit-docker.so

RUN --mount=type=bind,source=move2docker,target=/tmp/move2docker rsync -a --no-perms --no-owner --no-group --chmod=755 --keep-dirlinks /tmp/move2docker/* /;

ENV EDITOR vim \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENTRYPOINT ["/sbin/runit-docker"]

