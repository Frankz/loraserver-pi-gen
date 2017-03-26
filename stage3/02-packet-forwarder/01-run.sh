#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/semtech
mkdir -p /opt/semtech
cd /opt/semtech && git clone -v https://github.com/Lora-net/lora_gateway.git
cd /opt/semtech && git clone -v https://github.com/Lora-net/packet_forwarder.git

cd /opt/semtech/lora_gateway && make all
cd /opt/semtech/packet_forwarder && make all

EOF

install -m 755 files/start.sh   ${ROOTFS_DIR}/opt/semtech/packet_forwarder/lora_pkt_fwd
install -m 644 files/global_conf.json   ${ROOTFS_DIR}/opt/semtech/packet_forwarder/lora_pkt_fwd
install -m 644 files/packet-forwarder.service   ${ROOTFS_DIR}/lib/systemd/system/

on_chroot << EOF

systemctl enable packet-forwarder

EOF
