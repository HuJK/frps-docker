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
apt-get -y install runit locales rsync curl wget
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
mv frp/frpc /bin/frpc
chmod 755 /bin/frps
chmod 755 /bin/frpc
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
rm /tmp/install_syncer.sh
exit 0
