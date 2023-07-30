[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/igromchenko/netology_18-ansible)](https://github.com/igromchenko/netology_18-Ansible/releases/tag/08-ansible-03-yandex)

Данный playbook производит установку ПО Clickhouse, Vector и Lighthouse на выделенные VM, подготовленные Terraform.
Осуществляет их предварительную настройку для совместной работы по хранению и отображению логов Vector.

Пользователю доступны следующие переменные:

| Имя переменной      | Значение по умолчанию                                            | Краткое описание               | 
|---------------------|------------------------------------------------------------------|--------------------------------|
| clickhouse_version  | 22.3.3.44                                                        | Версия дистрибутива ClickHouse |
| clickhouse_packages | [clickhouse-client, clickhouse-server, clickhouse-common-static] | Перечень пакетов Clickhouse    |
| vector_version      | 0.31.0                                                           | Версия дистрибутива Vector     |

Актуальная версия плейбука доступна по тэгу [08-ansible-03-yandex](https://github.com/igromchenko/netology_18-Ansible/releases/tag/08-ansible-03-yandex).