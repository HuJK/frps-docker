#!/bin/bash
set -x
set -e
export DEBIAN_FRONTEND=noninteractive
. /etc/lsb-release
function get_cpu_architecture()
{
    local cpuarch=$(uname -m)
    case $cpuarch in
         x86_64)
              echo "amd64";
              ;;
         aarch64)
              echo "arm64";
              ;;
         *)
              echo "Not supported cpu architecture: ${cpuarch}"  >&2
              exit 1
              ;;
    esac
}
cpu_arch=$(get_cpu_architecture)
echo "Install & update"
apt-get -y update
apt-get -y install runit build-essential rsync
gcc -shared -std=c99 -Wall -O2 -fPIC -D_POSIX_SOURCE -D_GNU_SOURCE  -Wl,--no-as-needed -ldl -o /lib/runit-docker.so /tmp/runit-docker.c
cd /tmp
#delete self
rm /tmp/install_builder.sh
exit 0
