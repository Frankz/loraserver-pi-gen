#!/bin/bash -e

install -m 644 files/create-loraserver-db.service   ${ROOTFS_DIR}/lib/systemd/system/

on_chroot << EOF

apt-get -t jessie-backports -y install postgresql-9.6

systemctl enable postgresql@9.6-main
systemctl enable redis-server
systemctl enable mosquitto
systemctl enable create-loraserver-db

EOF
