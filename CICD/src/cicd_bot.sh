#!/bin/bash -
#===============================================================================
#
#          FILE: cicd_bot.sh
#
#         USAGE: ./cicd_bot.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: dorenesh, 
#  ORGANIZATION: 
#       CREATED: 10/10/25 15:55:44
#      REVISION:  ---
#===============================================================================

BOT_TOKEN="8030080237:AAG2iV_l_zhArP4n3z-bzTNyNBG00RCzzwM"
URL="https://api.telegram.org/bot$BOT_TOKEN/sendMessage"
ID="1837693402"

if [[ $CI_JOB_STATUS = "success" ]]; then
    STATUS=✅
else
    STATUS=❌
fi

TEXT="Deploy stage: $1 $STATUS%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s -d "chat_id=$ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
