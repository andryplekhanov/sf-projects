# Homework 7.8.7

## Задание:

- Возьмите исходники простейшего [PHP-приложения](https://github.com/SkillfactoryCoding/devops_module10_compose).
- Добавьте docker-compose.yml конфигурацию с двумя сервисами: php и nginx.
- Nginx должен использовать готовый докер-образ, сервис php должен собираться из текущей директории. Для этого в репозитории есть Dockerfile.
- Добавьте healthcheck для php-сервиса, который ходил бы на http://nginx и проверял содержимое на наличие строки «works» (это можно сделать через curl и grep).
- Запустить приложение через Docker Compose.
- Результатом проверки будет скриншот из браузера по доступному приложению на http://127.0.0.1:80/ и содержимое docker-compose.yml.


## Решение:

- build: `docker-compose build`
- run: `docker-compose up`
- result: `http://127.0.0.1:80/ `

