#!/bin/bash
#===============================================================================
#
#          FILE: main.sh
#
#         USAGE: ./main.sh az az.az 3Mb
#
#   DESCRIPTION: 
#
#        AUTHOR: dorenesh
#  ORGANIZATION: 
#       CREATED: 10/14/25 09:56:54
#      REVISION:  ---
#===============================================================================

# рандомное число в диапазоне
random_number() {
    local min=$1
    local max=$2
    echo $(( RANDOM % (max - min + 1) + min ))
}

# Обход всех папок по указанному пути
traverse_dirs() {
    local current_dir=$1
    local list_folder_name=$2
    local list_file_name=$3
    local list_extence_name=$4

    generate_files $list_folder_name $list_file_name $list_extence_name $current_dir

    for dir in "$current_dir"*/; do
        echo $dir
        if [ -d "$dir" ] && [ -r "$dir" ]; then
            dir_name=$(basename "$dir")
            
            if [[ "$dir_name" != "bin" && "$dir_name" != "sbin" ]]; then
                
                generate_files $list_folder_name $list_file_name $list_extence_name $dir
                
                if [ "$(find "$dir" -maxdepth 1 -type d -not -path "$dir" -print -quit)" ]; then
                    traverse_dirs $dir $list_folder_name $list_file_name $list_extence_name
                fi
            fi
        fi
    done
}

# Проверка достаточно ли памяти
check_free_space() {
    free_space_gb=$(df -h / | awk 'NR=2 {print $4}')
    if [[ ! $free_space_gb =~ [0-9]+G ]]; then
        echo "В файловой системе осталось меньше 1 Гб"
        exit 1
    fi
}

generate_name(){
    local list_letters=$1
    local threshold=$2
    local count=$3

    first_letter=${list_letters:0:1} 
    length=${#list_letters}
    name=""
    if [ "$length" -lt "$threshold" ]; then
        for ((k=1; k<=threshold-1+count-length; k++)); do
            name+=${first_letter}
        done
    else
        for ((k=1; k<=i; k++)); do
            name+=${first_letter}
        done
    fi

    name+=${list_letters}"_"$(date +%d%m%y)
    echo $name
}

# Генерация файлов
generate_files() {
    local list_folder_name=$1
    local list_file_name=$2
    local list_extence_name=$3
    local current_folder=$4
    local mb_size=$5

    kb_size=$(( mb_size * 1024 ))
   
    local count_folder=$(random_number 1 20)

    for ((i=1; i<=count_folder; i++)); do
       
        check_free_space
        
        folder_path=$(generate_name $list_folder_name 5 i)

        # Создание папки
        #folder_path=$current_folder$folder_name
        if [ ! -d $folder_path ]; then
            mkdir -p $folder_path
            sudo sh -c "echo $(pwd)/$folder_path - $(ls -la $folder_path | awk 'NR==2 {print $6,$7,$8}') >> $log_path"
        else
            echo "Папка $folder_path уже существует"
            continue
        fi

        cd $current_dir$folder_name
        # Создание файлов
        local count_file=$(random_number 1 20)

        for ((j=1; j<=count_file; j++)); do
            check_free_space

            # Генерация названия файла
            file_base_name=$(generate_name $list_file_name 5 j)
            file_path=${file_base_name}"."${list_extence_name}
            #file_path=${folder_path}"/"${file_name}
            
            if [ ! -f $file_path ]; then
                sudo touch "$file_path"
                #sudo truncate -s $kb_size $file_path
                sudo sh -c "echo $(pwd)/$file_path - $(ls -la $file_path | awk 'NR==1 {print $6,$7,$8,"-",$5}') >> $log_path"
            else
                echo "Файл $file_path уже существует"
            fi
        done
    done
}

list_folder_name=$1
if [[ ! "$list_folder_name" =~ ^[a-z]+$ ]] || [ "${#list_folder_name}" -ge 7 ]; then
    echo "В {$1} должны содержаться только буквы алфавита"
    exit 1
fi
    
IFS='.' read -r list_file_name list_extence_name <<< "$2"
if [[ ! "$list_file_name" =~ ^[a-z]+$ ]] || 
    [[ ! "$list_extence_name" =~ ^[a-z]+$ ]] || 
    [ "${#name_file}" -ge 7 ] || 
        [ "${#name_extence}" -ge 3 ]; then
    echo "В {$2} должны содержаться только буквы алфавита"
    exit 1
fi

size=$(echo "$3" | sed 's/Mb//')
if [[ ! "$size" =~ ^[0-9]+$ ]] || [ "$size" -gt 100 ]; then
    echo "{$size} должно быть не более 100"
    exit 1
fi

echo -e "\n$list_folder_name - буквы изпользуемые в названии папок
$list_file_name - буквы изпользуемые в названии файлов
$list_extence_name - буквы используемые в расширении файлов
$size - размер файлов в Мб\n"


log_path="$(pwd)/log_file.log"

path="main_folder/"
traverse_dirs $path $list_folder_name $list_file_name $list_extence_name $size
