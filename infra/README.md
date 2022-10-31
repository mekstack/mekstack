# Terraform files for hosted services

В каждой поддиректории находятся Terraform и Ansible файлы для деплоя
определенного сервиса

## Deploy docs

Для использования терраформа необходимо зайти в проект docs и создать
Application Credentials, добавить их в `clouds.yaml` и назвать их docs.

Деплой ансиблом

    export DOCS_ROOT=/home/ubuntu/mekstack.docs/
    ansible-galaxy collection install community.general
    ansible-playbook -i docs/inventory docs/deploy.yml
