#!/bin/bash
set -x
set -e
export DEBIAN_FRONTEND=noninteractive
. /etc/lsb-release
echo "Install & update"
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install runit locales cron vim git build-essential rsync
exit 0
