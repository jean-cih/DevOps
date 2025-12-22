#!/bin/bash

if [ $# -ne 4 ]; then
    echo "Скрипт работает с четырьмя параметрами"
    exit 1
elif [ $1 -eq $2 ] || [ $3 -eq $4 ]; then
    echo "Параметры цвета фона и шрифта должны отличаться"
    echo "Вызовите скрипт еще раз без повторений смежных параметров"
    exit 1
fi

for param in $@; do
    if ! [[ $param =~ ^[1-6]$ ]]; then
        echo "Параметры должны быть в пределах от 1 до 6"
        exit 1
    fi
done

chmod +x color.sh
source color.sh
chmod +x print_color_info.sh
source print_color_info.sh
exit 0

