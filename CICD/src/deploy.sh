#!/bin/bash -
#===============================================================================
#
#          FILE: deploy.sh
#
#         USAGE: ./deploy.sh
#
#   DESCRIPTION: this is my first deploy
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: dorenesh, 
#  ORGANIZATION: 
#       CREATED: 10/10/25 15:19:55
#      REVISION:  ---
#===============================================================================

CAT_PATH=SimpleBashUtils/src/cat/s21_cat
GREP_PATH=SimpleBashUtils/src/grep/s21_grep
PROD_IP=jean@10.10.0.2
REMOTE_PATH=/usr/local/bin/

scp $CAT_PATH $GREP_PATH $PROD_IP:$REMOTE_PATH

ssh $PROD_IP ls $REMOTE_PATH

