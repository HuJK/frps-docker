#!/bin/bash
set -x
set -e
gcc -shared -std=c99 -Wall -O2 -fPIC -D_POSIX_SOURCE -D_GNU_SOURCE  -Wl,--no-as-needed -ldl -o /lib/runit-docker.so /tmp/runit-docker.c
#delete self
rm /tmp/install2.sh
set +e
exit 0
