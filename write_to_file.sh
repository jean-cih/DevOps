#!/bin/bash

read -p "Хотите записать данные в файл (Y/N)? " var

if [[ $var =~ [yY] ]]; then
    FILENAME=$(date '+%d_%m_%Y_%H_%M_%S.status')
    ./print_info.sh > $FILENAME
    echo "Информация сохранена в файл $FILENAME"
fi

