### 1. Настройка **gitlab-runner**

1. Поднимем виртуальную машину *Ubuntu Server 22.04 LTS*.
   - Скачаем с официального сайта образ: https://ubuntu.com/download/server

   ![](report_images/1.png)

   ![](report_images/2.png)

2. Скачаем и установим на виртуальную машину **gitlab-runner**.

```
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"

dpkg -i gitlab-runner_amd64.deb
```

![](report_images/3.png)

![](report_images/4.png)

3. Запустим **gitlab-runner** и зарегистрируем его для использования в текущем проекте (*DO6_CICD*).

![](report_images/5.png)

![](report_images/6.png)

### 2. Сборка

1. Напишем этап для **CI** по сборке приложений из проекта *SimpleBashUtils*.

![](report_images/7.png)

2. В файле *.gitlab-ci.yml* добавь этап запуска сборки через мейк файл из проекта *SimpleBashUtils*.

![](report_images/8.png)

Для проверки необходимо включить и запустить ранер.

```
sudo gitlab-runner start
sudo gitlab-runner run
```

3. На странице проекта в GitLab нужно зайти в раздел Pipelines и посмотреть состояние конвейера:

   ![](report_images/9.png)

   ![](report_images/10.png)

   ![](report_images/11.png)

### 3. Тест кодстайла

1. Напишем этап для **CI**, который запускает скрипт кодстайла (*clang-format*).

![](report_images/12.png)

2. Запушим изменение в ветку и Pipeline автоматически запустится:

![](report_images/13.png)

![](report_images/14.png)

![](report_images/15.png)

### 4. Интеграционные тесты

1. Напишем этап для **CI**, который запустит интеграционные тесты. 
   - Запустить этот этап автоматически только при условии, если сборка и тест кодстайла прошли успешно. Если тесты не прошли, то «зафейлить» пайплайн. 
   - В пайплайне отобразить вывод, что интеграционные тесты успешно прошли / провалились.

![](report_images/16.png)

2. Запушим изменение в ветку и Pipeline автоматически запустится:

![](report_images/17.png)

![](report_images/18.png)

![](report_images/19.png)

### 5. Этап деплоя

1. Поднимем вторую виртуальную машину *Ubuntu Server 22.04 LTS*.
   - Склонируем виртуальную машину dorenesh1:

![](report_images/20.png)

![](report_images/21.png)

2. Настроим роуты на машинах

```
vim /etc/netplan/00-installer-config.yaml
```

![](report_images/22.png)

![](report_images/23.png)

```
sudo netplan apply
```

3. Напиши bash-скрипт, который при помощи **ssh** и **scp** копирует файлы, полученные после сборки (артефакты), в директорию */usr/local/bin* второй виртуальной машины.

![](report_images/24.png)

4. В файле *.gitlab-ci.yml* добавь этап запуска написанного скрипта.

![](report_images/25.png)

### 6. Дополнительно. Уведомления

Настроим уведомления об успешном/неуспешном выполнении пайплайна через бота с именем «dorenesh CI/CD» в *Telegram*.

1. Чтобы создать бота, напишем @botfather в Telegram:

![](report_images/26.png)

2. Напишем bash скрипт для отправки сообщений в Telegram:

![](report_images/27.png)

3. Расширим *.gitlab-ci.yml* ,чтобы после каждой стадии нам приходило сообщение со статусом:

![](report_images/25.png)

4. Проверяем, что получилось:

![](report_images/28.png)
