#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Использование: script.sh file_1 file_2 ..."
    exit 1
fi

for file in "$@"; do
    echo -e "\n=== Анализ файла $file ==="

    if [ -e "$file" ]; then
        echo "  Основная инфа:"
        ls -l "$file"
        echo ""

        echo "  Тип файла:"
        if [ -f "$file" ]; then
            echo "      Обычный файл"
        elif [ -d "$file" ]; then
            echo "      Директория"
        elif [ -L "$file" ]; then
            echo "      Символическая ссылка"
        elif [ -b "$file" ]; then
            echo "      Блочное устройство"
        elif [ -c "$file" ]; then
            echo "      Символьное устройство"
        elif [ -p "$file" ]; then
            echo "      Именованный канал"
        elif [ -S "$file" ]; then
            echo "      Сокет"
        else
            echo "      Неизвестный тип файла"
        fi

        echo "  Размер:"
        if [ -f "$file" ]; then
            size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
            echo "      $size байт"
        else
            echo "      (размер не доступен для данного типа файла)"
        fi

        echo "  Владелец:"
        owner=$(stat -c%U "$file" 2>/dev/null || stat -f%Su "$file" 2>/dev/null)
        group=$(stat -c%G "$file" 2>/dev/null || stat -f%Sg "$file" 2>/dev/null)
        echo "      Владелец: $owner"
        echo "      Группа: $group"

        echo "  Права доступа:"
        permissions=$(stat -c%A "$file" 2>/dev/null || ls -l "$file" | cut -d' ' -f1)
        echo "      $permissions"
        
        echo "  Дата последнего изменения:"
        mod_time=$(stat -c%y "$file" 2>/dev/null || stat -f%Sm "$file" 2>/dev/null)
        echo "      $mod_time"
        
    else
        echo "Ошибка: Файл $file не существует"
    fi
done

exit 0
