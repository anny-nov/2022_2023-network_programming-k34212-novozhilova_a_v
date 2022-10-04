#!/bin/sh
DEV='ens3'
PRIVATE=10.8.0.0/24
if [ -z "$DEV" ]; then
DEV="$(ip route | grep default | head -n 1 | awk '{print $5}')"
fi

sysctl net.ipv4.ip_forward=1

iptables -I FORWARD -j ACCEPT
iptables -t nat -I POSTROUTING -s $PRIVATE -o $DEV -j MASQUERADE