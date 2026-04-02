# Запуск dbt test

Добавьте файл схемы с тестами для модели:

```
cat > /root/my_dbt_project/models/schema.yml << 'EOF'
version: 2

models:
  - name: taxi_zone_summary
    description: "Сводка поездок по зонам посадки"
    columns:
      - name: pickup_zone_id
        tests:
          - unique
          - not_null
      - name: total_trips
        tests:
          - not_null
      - name: avg_total_amount
        tests:
          - not_null
EOF
```{{exec}}

Запустите тесты:

```
cd /root/my_dbt_project && dbt test
```{{exec}}

Все 4 теста должны пройти успешно. dbt проверил, что:
- `pickup_zone_id` уникален и не содержит NULL
- `total_trips` не содержит NULL
- `avg_total_amount` не содержит NULL

Также можно запустить всё вместе:

```
dbt build
```{{exec}}

`dbt build` запускает модели и тесты в порядке зависимостей одной командой.
