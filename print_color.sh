#!/bin/bash

declare -A COLORS_BACKGROUND
COLORS_BACKGROUND=( ['47']='white' ['41']='red' ['42']='green' ['44']='blue' ['45']='purple' ['40']='black' )

declare -A COLORS_FONT
COLORS_FONT=( ['37']='white' ['31']='red' ['32']='green' ['34']='blue' ['35']='purple' ['30']='black' )

declare -A COLORS_BACKGROUND_NUM
COLORS_BACKGROUND_NUM=( ['47']='1' ['41']='2' ['42']='3' ['44']='4' ['45']='5' ['40']='6' )

declare -A COLORS_FONT_NUM
COLORS_FONT_NUM=( ['37']='1' ['31']='2' ['32']='3' ['34']='4' ['35']='5' ['30']='6' )

if [[ $5 -eq 0 ]]; then
    echo -e "\nColumn 1 background = ${COLORS_BACKGROUND_NUM[$1]} (${COLORS_BACKGROUND[$1]})"
    echo "Column 1 font color = ${COLORS_FONT_NUM[$2]} (${COLORS_FONT[$2]})"
    echo "Column 2 background = ${COLORS_BACKGROUND_NUM[$3]} (${COLORS_BACKGROUND[$3]})"
    echo "Column 2 font color = ${COLORS_FONT_NUM[$4]} (${COLORS_FONT[$4]})"
else
    echo -e "\nColumn 1 background = default (${COLORS_BACKGROUND[$1]})"
    echo "Column 1 font color = default (${COLORS_FONT[$2]})"
    echo "Column 2 background = default (${COLORS_BACKGROUND[$3]})"
    echo "Column 2 font color = default (${COLORS_FONT[$4]})"
fi
