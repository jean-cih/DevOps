#!/bin/bash

chmod +x color_config.sh
source color_config.sh

FLAG=0

if [[ -z $COLUMN1_BACKGROUND ]] || 
    [[ -z $COLUMN1_FONT_COLOR ]] || 
    [[ -z $COLUMN2_BACKGROUND ]] || 
    [[ -z $COLUMN2_FONT_COLOR ]] ||  
    [[ ! $COLUMN1_BACKGROUND =~ ^[1-6]$ ]] || 
    [[ ! $COLUMN1_FONT_COLOR =~ ^[1-6]$ ]] || 
    [[ ! $COLUMN2_BACKGROUND =~ ^[1-6]$ ]] || 
    [[ ! $COLUMN2_FONT_COLOR =~ ^[1-6]$ ]] || 
    [[ $COLUMN1_BACKGROUND -eq $COLUMN1_FONT_COLOR ]] || 
    [[ $COLUMN2_BACKGROUND -eq $COLUMN2_FONT_COLOR ]]; then
            chmod +x default_color_config.sh
            source default_color_config.sh
            COLUMN1_BACKGROUND=$COLUMN1_BACKGROUND_DEF
            COLUMN1_FONT_COLOR=$COLUMN1_FONT_COLOR_DEF
            COLUMN2_BACKGROUND=$COLUMN2_BACKGROUND_DEF
            COLUMN2_FONT_COLOR=$COLUMN2_FONT_COLOR_DEF
            FLAG=1
fi

if [ $# -ne 0 ]; then
    echo "Скрипт запускается без параметров"
    exit 1
elif [[ $COLUMN1_BACKGROUND -eq $COLUMN1_FONT_COLOR ]] || [[ $COLUMN2_BACKGROUND -eq $COLUMN2_FONT_COLOR ]]; then
    echo "Первый и третий, второй и четверты параметр в конфиге должены отличаться"
    echo "Измените параметры и запустите скрипт еще раз"
    exit 1
fi

chmod +x ../03/print_color_info.sh
chmod +x ../03/color.sh
chmod +x print_color.sh
source ../03/color.sh $COLUMN1_BACKGROUND $COLUMN1_FONT_COLOR $COLUMN2_BACKGROUND $COLUMN2_FONT_COLOR
source ../03/print_color_info.sh
source print_color.sh $COLUMN1_BACKGROUND $COLUMN1_FONT_COLOR $COLUMN2_BACKGROUND $COLUMN2_FONT_COLOR $FLAG



