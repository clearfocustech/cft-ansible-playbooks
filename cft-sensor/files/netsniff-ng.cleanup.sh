#!/bin/sh
## Keep configure dminutes worth of pcap data
source /etc/sysconfig/netsniff-ng
find $DATA_DIR -type f -mmin +$DATA_EXPIRE -uid $USER -exec rm -f {} \;
