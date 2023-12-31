# Проектная работа 7 (HW-03)

## Задачи

- Создать ВМ в Я.Облаке (минимальная конфигурация: 2vCPU, 2GB RAM, 20GB HDD).
- Установить и запустить на ВМ Docker.
- Установить и запустить на ВМ СУБД Postgres.
- В Postgres создать БД и пользователя с произвольным именем на ваш выбор и дать этому пользователю полные права на созданную БД.
- Создать Docker-образ:
  - Содержащий Python 3, а также библиотеки для него: **Flask**, **Psycopg2** (для работы с СУБД Postgres, хранящей данные) и **ConfigParser**.
  - Содержащий код приложения на Python (копирующий его с локальной файловой системы). На хостовой ФС код будет лежать по пути: `/srv/app/web.py`.
  - Содержащий конфигурационный файл приложения (копирующий его с локальной ФС). На хостовой ФС конфигурационный файл будет лежать по пути: `/srv/app/conf/web.conf`.
  - При запуске контейнера, он должен запускать описанный выше код.
  - Образ должен быть оптимизирован с учетом лучших практик.
  - Пришлите ментору свой Dockerfile, скриншот с работающим приложением и размер образа.

Для проверки работоспособности образа можно использовать [приложение из репозитория](https://github.com/SkillfactoryCoding/DEVOPS-praktikum_Docker) (не забудьте поправить конфиг-файл).

Для этого потребуется склонировать репозиторий из GitHub (заодно вспомним, как работать с Git), создать директорию /srv/app/conf и расположить файлы из склонированного репозитория так:

- web.py расположить в `/srv/app/`
- web.conf расположить в `/srv/app/conf/`.

Затем запустить Docker-контейнер, смонтировав `/srv/app` с хостовой ФС в контейнерную, а также пробросив порт **80** из контейнера в хостовую сеть.


## Решение

Первые 2 пункта выполняются автоматически с помощью **Terraform** и **Ansible**.

**! ВНИМАНИЕ !** Файлы **"inventory.ini"** и **"variables.yml"** для Ansible создаются автоматически во время работы Terraform. Без запуска Terraform не получится запустить Ansible.


## Запуск

- **Terraform** и **Ansible** должны быть установлены на вашей системе Linux.
- Скачать проект
- Перейти в директорию `project-7_HW-03/terraform`
- В файле `variables.tf` прописать значения для переменных **"cloud_id"**, **"folder_id"** и **"token"** от вашего Yandex Cloud
- Запустить команды `terraform init` и `terraform apply`
- Подождать 3-5 мин. пока инстансы заварятся и настоятся
- Перейти в директорию `project-7_HW-03/ansible`
- Запустить команду `ansible-playbook playbook.yml -i inventory.ini`
- Подключиться по ssh к **vm1**: `ssh andrey@<ip-vm1>`
- Установить вручную **git**, **postgresql** и **postgresql-contrib**
- Настроить вручную **postgresql** (напр. как [здесь](https://github.com/andryplekhanov/Dj_project#configure-postgresql))
- Скачать гитом [проект](https://github.com/SkillfactoryCoding/DEVOPS-praktikum_Docker) на **vm1** и перенести в ту же директорию Dockerfile
- Открыть файл **web.conf** и прописать данные для подключения к **postgresql**
- Смонтировать образ: `docker build . -t flaskapp-img`
- Запустить контейнер: `docker run -d --name flaskapp-app -p 80:5000 flaskapp-img`
- Не забываем в конце удалить инстансы: `terraform destroy`
