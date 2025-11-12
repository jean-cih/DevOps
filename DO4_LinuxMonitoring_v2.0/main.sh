#!/bin/bash
#===============================================================================
#
#          FILE: main.sh
#
#         USAGE: ./main.sh /opt/test 4 az 5 az.az 3kb
#
#   DESCRIPTION: This is The File Generator
#
#        AUTHOR: dorenesh, 
#  ORGANIZATION: 
#       CREATED: 10/10/25 18:25:40
#      REVISION:  ---
#===============================================================================

# Проверка достаточно ли памяти
check_free_storage(){
    free_space_gb=$(df -h / | awk 'NR=2 {print $4}')
    if [[ ! $free_space_gb =~ [0-9]+G ]]; then
        echo "В файловой системе осталось меньше 1 Гб"
        exit 1
    fi
}

# Генерация названия папки
generate_name(){
    local list_name=$1
    local threshold=$2
    local count=$3

    first_letter=${list_name:0:1} 
    length=${#list_name}
    name=""
    if [ ${length} -lt $threshold ]; then
        for ((k=1; k<=threshold-1+count-length; k++)); do
            name+=${first_letter}
        done
    else
        for ((k=1; k<=count; k++)); do
            name+=${first_letter}
        done
    fi 

    name+=${list_name}"_"$(date +%d%m%y)
    
    echo $name
}

generate_tree(){
    local amount_folder=$1
    local list_folder_name=$2
    local amount_file=$3
    local list_file_name=$4
    local list_extence_name=$5
    local size=$6

    log_path="$(pwd)/log_file.log"
    for ((i=1; i<=amount_folder; i++)); do

        check_free_storage

        folder_name=$(generate_name $list_folder_name 4 i)

        # Создание папки
        if [ ! -d $folder_name ]; then
            sudo mkdir $folder_name
            sudo sh -c "echo $(pwd)/$folder_name - $(ls -la $folder_name | awk 'NR==2 {print $6,$7,$8}') >> $log_path"
        else
            echo "Папка $folder_name уже существует"
        fi

        cd $folder_name
    
        # Создание файлов
        for ((j=1; j<=amount_file; j++)); do
            check_free_storage

            file_base_name=$(generate_name $list_file_name 4 j)

            file_name=${file_base_name}"."${list_extence_name}
        
            if [ ! -f $file_name ]; then
                sudo touch $file_name
                sudo truncate -s $size $file_name
                sudo sh -c "echo $(pwd)/$file_name - $(ls -la $file_name | awk 'NR==1 {print $6,$7,$8,"-",$5}') >> $log_path"
            else
                echo "Файл $file_name уже существует"
            fi
        done

    done
}

path=$1
if [ "${path:0:1}" != "/" ]; then
    echo "{$path} должен быть абсолютным путем"
    exit 1
fi

amount_folder=$2
if [[ ! "$2" =~ ^[0-9]+$ ]]; then
    echo "В {$amount_folder} должно содержаться положительное число"
    exit 1
fi

list_folder_name=$3
if [[ ! "$list_folder_name" =~ ^[a-z]+$ ]] || [ "${#list_folder_name}" -ge 7 ]; then
    echo "В {$3} должны содержаться только буквы алфавита"
    exit 1
fi
    
amount_file=$4
if [[ ! "$amount_file" =~ ^[0-9]+$ ]]; then
    echo "В {$amount_file} должно содержаться положительное число"
    exit 1
fi

IFS='.' read -r list_file_name list_extence_name <<< "$5"
if [[ ! "$list_file_name" =~ ^[a-z]+$ ]] || 
    [[ ! "$list_extence_name" =~ ^[a-z]+$ ]] || 
    [ "${#name_file}" -ge 7 ] || 
        [ "${#name_extence}" -ge 3 ]; then
    echo "В {$3} должны содержаться только буквы алфавита"
    exit 1
fi


size=$(echo "$6" | sed 's/kb//')
if [[ ! "$size" =~ ^[0-9]+$ ]] || [ "$size" -gt 100 ]; then
    echo "{$size} должно быть не более 100"
    exit 1
fi

echo -e "\n$path - абсолютный путь
$amount_folder - количество вложенных папок
$list_folder_name - буквы изпользуемые в названии папок
$amount_file - количество файлов в каждой папке
$list_file_name - буквы изпользуемые в названии файлов
$list_extence_name - буквы используемые в расширении файлов
$size - размер файлов в кб\n"

if [ ! -d "$path" ]; then
    sudo mkdir -p "$path"
    echo -e "\n$path - такой папки не было, я ее создал"
fi

cd $path
generate_tree $amount_folder $list_folder_name $amount_file $list_file_name $list_extence_name $size

