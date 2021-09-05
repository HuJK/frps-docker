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
apt-get -y install runit build-essential rsync curl wget
gcc -shared -std=c99 -Wall -O2 -fPIC -D_POSIX_SOURCE -D_GNU_SOURCE  -Wl,--no-as-needed -ldl -o /lib/runit-docker.so /tmp/runit-docker.c
cd /tmp
echo "###doenload latest frp###"
curl -s https://api.github.com/repos/fatedier/frp/releases/latest \
| grep "browser_download_url.*linux_${cpu_arch}.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i - -O frp.tar.gz

echo "###unzip frp.tar.gz###"
mkdir frp
tar xzvf frp.tar.gz -C frp
mv frp/*/* frp/
mv frp/frps /bin/frps
chmod 755 /bin/frps
rm -rf frp
rm -rf frp.tar.gz

echo "###doenload latest frp-multiuser###"
curl -s https://api.github.com/repos/gofrp/fp-multiuser/releases/latest \
| grep "browser_download_url.*linux-${cpu_arch}" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i - -O fp-multiuser
mv fp-multiuser /bin/fp-multiuser
chmod 755 /bin/fp-multiuser
#delete self
rm /tmp/install_builder.sh
exit 0
