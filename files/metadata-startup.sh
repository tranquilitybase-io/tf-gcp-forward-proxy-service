#!/bin/bash

set -euo pipefail

exec >> /var/log/metadata_startup.log 2>&1
echo "metadata_start"

apt install -y squid

#Add IAP source CIDR
echo "acl localnet src 35.235.240.0/20" | tee -a /etc/squid/squid.conf
systemctl enable squid
systemctl start squid

echo "metadata_end"
