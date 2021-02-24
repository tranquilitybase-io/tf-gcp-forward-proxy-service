#!/bin/bash

set -euo pipefail

exec >> /var/log/metadata_startup.log 2>&1
echo "metadata_start"

apt install -y squid

systemctl enable squid
systemctl start squid

echo "metadata_end"
