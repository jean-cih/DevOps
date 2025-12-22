#!/bin/bash

MAIN_PATH="$1"

TOTAL_FOLDERS=$(find $MAIN_PATH -type d 2>/dev/null | wc -l)
TOP_FOLDERS=$(du -h "$MAIN_PATH" 2>/dev/null | sort -hr | head -n 5 | awk '{printf "%d - %s, %s\n", NR, $2, $1}')
NUMBER_FILES=$(find $MAIN_PATH -type f 2>/dev/null | wc -l)
NUMBER_CONF=$(find $MAIN_PATH -type f -name "*.conf" 2>/dev/null | wc -l)
NUMBER_TXT=$(find $MAIN_PATH -type f -name "*.txt" 2>/dev/null | wc -l)
NUMBER_EXE=$(find $MAIN_PATH -type f -executable 2>/dev/null | wc -l)
NUMBER_LOG=$(find $MAIN_PATH -type f -name "*.log" 2>/dev/null | wc -l)
NUMBER_ARCH=$(find $MAIN_PATH -type f -name "*.zip" -o -name "*.7z" -o -name "*.rar" -o -name "*.gz" -o -name "*.tar" 2>/dev/null | wc -l)
LINKS=$(find $MAIN_PATH -type l 2>/dev/null | wc -l)
TOP_LARGEST_FILES=$(find $MAIN_PATH -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{ext=""; file=$2; sub(".*/", "", file); if (index(file, ".") > 0) { n=split(file, arr, "."); ext=arr[n];} printf "%d - %s, %s%s\n", NR, $2, $1, (ext == "" ? "" : ", "ext)}')
TOP_LARGEST_EXE=$(find $MAIN_PATH -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}')
