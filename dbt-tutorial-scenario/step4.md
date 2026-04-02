# Запуск dbt test

Добавьте файл схемы с тестами для модели:

```
cat > /root/my_dbt_project/models/schema.yml << 'EOF'
version: 2

models:
  - name: customer_orders
    description: "Сводка заказов по клиентам"
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
      - name: name
        tests:
          - not_null
      - name: total_orders
        tests:
          - not_null
EOF
```{{exec}}

Запустите тесты:

```
cd /root/my_dbt_project && dbt test
```{{exec}}

Все 4 теста должны пройти успешно. dbt проверил, что:
- `customer_id` уникален и не содержит NULL
- `name` не содержит NULL
- `total_orders` не содержит NULL

Также можно запустить всё вместе:

```
dbt build
```{{exec}}

`dbt build` запускает модели и тесты в порядке зависимостей одной командой.
