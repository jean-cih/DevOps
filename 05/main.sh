#!/bin/bash

chmod +x get_info.sh
chmod +x print_info.sh

MY_PATH=$1

if [[ ${MY_PATH: -1} != "/" ]]; then
    echo "Путь должен заканчиваться на '/'"
    exit 1
elif ! [[ -d $MY_PATH ]]; then
    echo "Такой директории не существует"
    exit 1
elif [[ $# -ne 1 ]]; then
    echo "Скрипт работает с одним параметром"
    exit 1
fi

source get_info.sh $MY_PATH
source print_info.sh

echo "Script execution time (in seconds) = $SECONDS"
exit 0
