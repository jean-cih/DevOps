#!/bin/bash

chmod +x print_info.sh
chmod +x write_to_file.sh

if [ $# -eq 0 ]; then
    source print_info.sh
    source write_to_file.sh
else
    echo "Скрипт работает без параметров"
    exit 1
fi

exit 0
