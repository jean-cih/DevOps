#!/bin/bash

chmod +x get_info.sh
source get_info.sh

echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
