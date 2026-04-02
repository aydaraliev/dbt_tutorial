# Запуск dbt test

Добавьте файл схемы с тестами для модели:

```
cat > /root/nyc_yellow_taxi/models/taxi_rides/schema.yml << 'EOF'
version: 2

models:
  - name: taxi_rides_raw
    description: "Сырые данные поездок NYC Yellow Taxi"
    columns:
      - name: VendorID
        tests:
          - not_null
      - name: total_amount
        tests:
          - not_null
      - name: trip_distance
        tests:
          - not_null
EOF
```{{exec}}

Запустите тесты:

```
cd /root/nyc_yellow_taxi && dbt test
```{{exec}}

Все 3 теста должны пройти успешно.

Также можно запустить всё вместе:

```
dbt build
```{{exec}}

`dbt build` запускает модели и тесты в порядке зависимостей одной командой.
