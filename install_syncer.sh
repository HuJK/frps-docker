#!/bin/bash
set -x
set -e
export DEBIAN_FRONTEND=noninteractive
. /etc/lsb-release
echo "Install & update"
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install runit locales git rsync
#delete self
rm /tmp/install_syncer.sh
exit 0
