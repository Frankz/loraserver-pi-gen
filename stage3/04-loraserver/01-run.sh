#!/bin/bash -e

install -m 644 files/lora-app-server   ${ROOTFS_DIR}/etc/default
install -m 644 files/loraserver        ${ROOTFS_DIR}/etc/default
install -m 644 files/default           ${ROOTFS_DIR}/etc/nginx/sites-available

on_chroot << EOF

systemctl enable lora-gateway-bridge
systemctl enable lora-app-server
systemctl enable loraserver
systemctl enable nginx

EOF