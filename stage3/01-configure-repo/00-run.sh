#!/bin/bash -e

on_chroot << EOF
# debian
rm -f /etc/apt/sources.list.d/jessie-backports.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
echo 'deb http://httpredir.debian.org/debian jessie-backports main contrib non-free' | sudo tee -a /etc/apt/sources.list.d/jessie-backports.list

# loraserver
rm -f /etc/apt/sources.list.d/loraserver.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1CE2AFD36DBCCA00
echo "deb https://repos.loraserver.io/debian jessie testing" | sudo tee /etc/apt/sources.list.d/loraserver.list

apt-get update
EOF
