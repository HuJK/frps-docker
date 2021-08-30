#!/bin/bash
set -x
set -e
export DEBIAN_FRONTEND=noninteractive
. /etc/lsb-release
echo "Install & update"
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install runit build-essential rsync
gcc -shared -std=c99 -Wall -O2 -fPIC -D_POSIX_SOURCE -D_GNU_SOURCE  -Wl,--no-as-needed -ldl -o /lib/runit-docker.so /tmp/runit-docker.c
#delete self
rm /tmp/install_builder.sh
exit 0
