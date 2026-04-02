# Установка dbt и настройка PostgreSQL

В фоновом режиме выполняется скрипт установки PostgreSQL и dbt.

Дождитесь завершения установки:

```
while [ ! -f /tmp/setup-done ]; do echo "Ожидание установки..."; sleep 2; done && echo "Установка завершена!"
```{{exec}}

Проверьте, что dbt установлен:

```
dbt --version
```{{exec}}

Проверьте, что PostgreSQL запущен и содержит тестовые данные:

```
sudo -u postgres psql -d dbt_db -c "SELECT * FROM raw.customers;"
```{{exec}}

```
sudo -u postgres psql -d dbt_db -c "SELECT * FROM raw.orders;"
```{{exec}}

В выводе должно быть 3 клиента и 5 заказов.
