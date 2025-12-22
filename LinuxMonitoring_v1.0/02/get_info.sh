#!/bin/bash

HOSTNAME=$HOSTNAME
TIMEZONE=$(cat /etc/timezone)
USER=$(whoami)
OS=$(head -n 1 /etc/os-release | cut -d '"' -f 2)
DATE=$(date '+%d %b %Y %H:%M:%S')
UPTIME=$(uptime -p | awk -F 'up ' '{print $2}')
UPTIME_SEC=$(awk '{print $1}' /proc/uptime)
IP=$(ifconfig lo | grep inet | head -n 1 | awk '{print $2}')
MASK=$(ifconfig lo | grep inet | head -n 1 | awk '{print $4}')
GATEWAY=$(ip r | awk '/default/ {print $4}')
RAM_TOTAL=$(free -h | awk '/Mem:/ {printf "%.3f GB",$2}')
RAM_USED=$(free -h | awk '/Mem:/ {printf "%.3f GB",$3}')
RAM_FREE=$(free -h | awk '/Mem:/ {printf "%.3f GB",$4}')
SPACE_ROOT=$(df -BM / | tail -n 1 | awk '{printf "%.2f MB",$2}')
SPACE_ROOT_USED=$(df -BM / | tail -n 1 | awk '{printf "%.2f MB",$3}')
SPACE_ROOT_FREE=$(df -BM / | tail -n 1 | awk '{printf "%.2f MB",$4}')
